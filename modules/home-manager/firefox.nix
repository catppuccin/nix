{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  mkFirefoxModule =
    name:
    let
      cfg = config.catppuccin.${name};

      # ID for the chosed theme's addon
      addonId = sources.firefox.addonIds.${cfg.flavor}.${cfg.accent};
      upperName = catppuccinLib.mkUpper name;
    in
    {
      options.catppuccin.${name} =
        catppuccinLib.mkCatppuccinOption {
          inherit name;
          accentSupport = true;
        }
        // {
          finalPackage = lib.mkOption {
            type = lib.types.package;
            readOnly = true;
            visible = false;
            description = "Resulting ${upperName} package";
          };
          profiles = lib.mkOption {
            type = with lib.types; listOf str;
            description = "${upperName} profiles to install the Catppuccin theme addon on";
            example = lib.literalExpression ''[ "default" "default-release" "work" ]'';
          };
        };
      config = lib.mkIf cfg.enable {
        catppuccin.${name}.finalPackage = pkgs.${name}.override (previous: {
          extraPrefsFiles = (previous.extraPrefsFiles or [ ]) ++ [
            (pkgs.writeTextFile {
              name = "catppuccin.cfg";
              text = ''
                // Immutably set theme
                lockPref("extensions.activeThemeID", "${addonId}");
                // Immutably disable syncing the active theme to avoid issues just in case
                lockPref("services.sync.prefs.sync.extensions.activeThemeID", false);
              '';
            })
          ];
        });
        programs.${name} = {
          profiles = lib.genAttrs cfg.profiles (_: {
            extensions = [ sources.firefox."${cfg.flavor}_${cfg.accent}" ];
          });
          package = cfg.finalPackage;
        };
      };
    };
in
lib.foldl (acc: name: lib.recursiveUpdate acc (mkFirefoxModule name)) { } [
  "firefox"
  "floorp"
  "librewolf"
]

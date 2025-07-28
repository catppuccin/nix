{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (lib)
    importJSON
    toSentenceCase
    mkIf
    mkOption
    getAttrFromPath
    setAttrByPath
    types
    ;

  inherit (config.catppuccin) sources;
  themes = importJSON "${sources.firefox}/themes.json";

  mkFirefoxModule =
    {
      name,
      prettyName ? toSentenceCase name,
      hmModulePath ? [
        "programs"
        name
      ],
    }:
    let
      modulePath = [
        "catppuccin"
        name
      ];

      cfg = getAttrFromPath modulePath config;

      mkProfileOptions =
        {
          forceDefault ? false,
          enableDefault ? null,
        }:
        catppuccinLib.mkCatppuccinOption (
          {
            inherit name;
            accentSupport = true;
          }
          // (lib.optionalAttrs (enableDefault != null) {
            default = enableDefault;
          })
        )
        // {
          force = mkOption {
            type = types.bool;
            default = forceDefault;
            description = "Forcibly override any existing configuration for Firefox Color.";
            example = true;
          };
        };
    in
    {
      options =
        (setAttrByPath modulePath (
          (mkProfileOptions { })
          // {
            profiles = mkOption {
              type = types.attrsOf (
                types.submodule {
                  options = mkProfileOptions {
                    enableDefault = cfg.enable;
                    forceDefault = cfg.force;
                  };
                  config = {
                    flavor = lib.mkDefault cfg.flavor;
                    accent = lib.mkDefault cfg.accent;
                  };
                }
              );
              default = { };
              description = "Catppuccin settings for ${prettyName} profiles.";
            };
          }
        ))
        # home-manager browser config
        // (setAttrByPath hmModulePath {
          profiles = mkOption {
            type = types.attrsOf (
              types.submodule (
                { name, ... }:
                let
                  profile = cfg.profiles.${name} or cfg;
                in
                {
                  config = mkIf profile.enable {
                    extensions = {
                      settings."FirefoxColor@mozilla.com" = {
                        inherit (profile) force;
                        settings = {
                          firstRunDone = true;
                          theme = themes.${profile.flavor}.${profile.accent};
                        };
                      };
                    };
                  };
                }
              )
            );
          };
        });
    };
in
{
  imports = map mkFirefoxModule [
    { name = "firefox"; }
    {
      name = "librewolf";
      prettyName = "LibreWolf"; # W in LibreWolf is uppercase
    }
    { name = "floorp"; }
  ];
}

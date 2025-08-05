{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.vscode;
  vscodeCfg = config.programs.vscode;

  profileSettingsFormat = pkgs.formats.json { };

  renamedOptions = [
    "accent"
    "enable"
    "flavor"
    "settings"
  ];
  ctpVscOptionPath = [
    "catppuccin"
    "vscode"
  ];

  catppuccinProfilesSubmodule =
    { config, ... }:

    {
      options =
        catppuccinLib.mkCatppuccinOption {
          name = "vscode";
          accentSupport = true;
        }
        // {
          settings = lib.mkOption {
            type = lib.types.submodule {
              freeformType = profileSettingsFormat.type;

              options = {
                accent = lib.mkOption {
                  type = catppuccinLib.types.accent;
                  default = config.accent;
                  description = "Catppuccin accent for vscode.";
                };
              };
            };
            default = { };
            description = ''
              Settings for the extension theme.

              See https://github.com/catppuccin/vscode/blob/8ac8c5e1db78174c98c55ecd9c1bd3a6f2cbbc0b/packages/catppuccin-vsc/src/theme/index.ts#L14-L25 for a full list of options.
            '';
          };

          icons = catppuccinLib.mkCatppuccinOption { name = "vscode-icons"; };
        };
    };

  vscodeConfigSubmodule =
    { name, ... }:

    let
      cfg' = cfg.profiles.${name} or { enable = false; };
    in

    lib.mkIf cfg'.enable (
      lib.mkMerge [
        {
          extensions = [
            (sources.vscode.override { catppuccinOptions = cfg'.settings; })
          ];

          userSettings = {
            "workbench.colorTheme" = "Catppuccin " + (catppuccinLib.mkFlavorName cfg'.flavor);
            "catppuccin.accentColor" = cfg'.accent;

            # Recommended settings
            # https://github.com/catppuccin/vscode?tab=readme-ov-file#vscode-settings
            "editor.semanticHighlighting.enabled" = lib.mkDefault true;
            "terminal.integrated.minimumContrastRatio" = lib.mkDefault 1;
            "window.titleBarStyle" = lib.mkDefault "custom";
          };

        }

        (lib.mkIf cfg'.icons.enable {
          extensions = [ sources.vscode-icons ];

          userSettings = {
            "workbench.iconTheme" = "catppuccin-" + cfg'.icons.flavor;
          };
        })
      ]
    );
in
{
  options = {
    catppuccin.vscode.profiles = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule catppuccinProfilesSubmodule);
      default = lib.genAttrs (lib.attrNames vscodeCfg.profiles) (lib.const { });
      description = "Catppuccin settings for VSCode profiles.";
    };

    programs.vscode.profiles = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule vscodeConfigSubmodule);
    };
  };

  # Rename old catppuccin.vscode.* options to catppuccin.vscode.profiles.<profile>.*
  /*
    imports = lib.foldl' (
      acc: name:

      acc
      ++ map (
        option:

        lib.mkRenamedOptionModule (ctpVscOptionPath ++ [ option ]) (
          ctpVscOptionPath
          ++ [
            "profiles"
            name
            option
          ]
        )
      ) renamedOptions
    ) [ ] (lib.attrNames cfg.profiles);
  */
}

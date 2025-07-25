{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.vscode;

  settingsFormat = pkgs.formats.json { };

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
  newOptionPath = ctpVscOptionPath ++ [
    "profiles"
    "default"
  ];
in
{
  # Rename old catppuccin.vscode.* options to catppuccin.vscode.profiles.<profile>.*
  imports = map (
    option: lib.mkRenamedOptionModule (ctpVscOptionPath ++ [ option ]) (newOptionPath ++ [ option ])
  ) renamedOptions;

  options.catppuccin.vscode.profiles = lib.mkOption {
    type = types.attrsOf (
      types.submodule (
        { config, ... }:
        {
          options =
            catppuccinLib.mkCatppuccinOption {
              name = "vscode";
              accentSupport = true;
            }
            // {
              settings = lib.mkOption {
                description = ''
                  Settings for the extension theme.

                  See https://github.com/catppuccin/vscode/blob/8ac8c5e1db78174c98c55ecd9c1bd3a6f2cbbc0b/packages/catppuccin-vsc/src/theme/index.ts#L14-L25 for a full list of options.
                '';

                default = { };

                type = types.submodule {
                  freeformType = settingsFormat.type;

                  options = {
                    accent = lib.mkOption {
                      type = catppuccinLib.types.accent;
                      default = config.accent;
                    };
                  };
                };
              };

              icons = catppuccinLib.mkCatppuccinOption { name = "vscode-icons"; };
            };
        }
      )
    );

    # by default we list the `default` profile to enable the theme with just the `.enable` option
    default = {
      default = { };
    };

    description = "Catppuccin settings for VSCode profiles.";
  };

  config.programs.vscode.profiles = lib.mapAttrs (
    _: profile:
    lib.mkIf profile.enable {
      extensions = [
        (sources.vscode.override { catppuccinOptions = profile.settings; })
      ]
      ++ lib.optional (profile.icons.enable) sources.vscode-icons;

      userSettings = lib.mkMerge [
        {
          "workbench.colorTheme" = "Catppuccin " + (catppuccinLib.mkFlavorName profile.flavor);
          "catppuccin.accentColor" = profile.accent;

          # Recommended settings
          # https://github.com/catppuccin/vscode?tab=readme-ov-file#vscode-settings
          "editor.semanticHighlighting.enabled" = lib.mkDefault true;
          "terminal.integrated.minimumContrastRatio" = lib.mkDefault 1;
          "window.titleBarStyle" = lib.mkDefault "custom";
        }

        (lib.mkIf (profile.icons.enable) {
          "workbench.iconTheme" = "catppuccin-" + profile.icons.flavor;
        })
      ];
    }
  ) cfg.profiles;
}

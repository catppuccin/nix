{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.k9s;
  enable = cfg.enable && config.programs.k9s.enable;

  # NOTE: On MacOS specifically, k9s expects its configuration to be in
  # `~/Library/Application Support` when not using XDG
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;

  themeName = "catppuccin-${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
  themeFile = "${themeName}.yaml";
  themePath = "k9s/skins/${themeFile}";
  theme = sources.k9s + "/${themeFile}";
in

{
  options.catppuccin.k9s = catppuccinLib.mkCatppuccinOption { name = "k9s"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "programs"
        "k9s"
        "catppuccin"
      ];
      to = "k9s";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "k9s"
          "catppuccin"
          "transparent"
        ]
        [
          "catppuccin"
          "k9s"
          "transparent"
        ]
      )
    ];

  config = lib.mkIf enable (
    lib.mkMerge [
      (lib.mkIf (!enableXdgConfig) {
        home.file = {
          "Library/Application Support/${themePath}".source = theme;
        };
      })

      (lib.mkIf enableXdgConfig { xdg.configFile.${themePath}.source = theme; })

      {
        programs.k9s = {
          settings = {
            k9s.ui.skin = themeName;
          };
        };
      }
    ]
  );
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.helix;
  enable = cfg.enable && config.programs.helix.enable;
  subdir = if cfg.useItalics then "default" else "no_italics";
in

{
  options.catppuccin.helix = catppuccinLib.mkCatppuccinOption { name = "helix"; } // {
    useItalics = lib.mkEnableOption "Italics in Catppuccin theme for Helix";
  };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "programs"
        "helix"
        "catppuccin"
      ];
      to = "helix";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "helix"
          "catppuccin"
          "useItalics"
        ]
        [
          "catppuccin"
          "helix"
          "useItalics"
        ]
      )
    ];

  config = lib.mkIf enable {
    programs.helix = {
      settings = {
        theme = "catppuccin-${cfg.flavor}";
        editor.color-modes = lib.mkDefault true;
      };
    };

    xdg.configFile = {
      "helix/themes/catppuccin-${cfg.flavor}.toml".source =
        "${sources.helix}/${subdir}/catppuccin_${cfg.flavor}.toml";
    };
  };
}

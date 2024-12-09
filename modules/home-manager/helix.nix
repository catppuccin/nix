{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.helix;
  enable = cfg.enable && config.programs.helix.enable;
in
{
  options.catppuccin.helix = lib.ctp.mkCatppuccinOpt { name = "helix"; } // {
    useItalics = lib.mkEnableOption "Italics in Catppuccin theme for Helix";
  };

  imports =
    (lib.ctp.mkRenamedCatppuccinOpts {
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
    programs.helix =
      let
        subdir = if cfg.useItalics then "default" else "no_italics";
      in
      {
        settings = {
          theme = "catppuccin-${cfg.flavor}";
          editor.color-modes = lib.mkDefault true;
        };

        themes."catppuccin-${cfg.flavor}" = lib.importTOML "${sources.helix}/themes/${subdir}/catppuccin_${cfg.flavor}.toml";
      };
  };
}

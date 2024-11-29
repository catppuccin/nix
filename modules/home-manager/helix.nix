{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.helix.catppuccin;
  enable = cfg.enable && config.programs.helix.enable;
in
{
  options.programs.helix.catppuccin = lib.ctp.mkCatppuccinOpt { name = "helix"; } // {
    useItalics = lib.mkEnableOption "Italics in Catppuccin theme for Helix";
  };

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

        themes."catppuccin-${cfg.flavor}" = lib.importTOML "${sources.helix}/${subdir}/catppuccin_${cfg.flavor}.toml";
      };
  };
}

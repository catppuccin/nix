{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.helix.catppuccin;
  subdir = if cfg.useItalics then "default" else "no_italics";
in

{
  options.programs.helix.catppuccin = catppuccinLib.mkCatppuccinOption { name = "helix"; } // {
    useItalics = lib.mkEnableOption "Italics in Catppuccin theme for Helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      settings = {
        theme = "catppuccin-${cfg.flavor}";
        editor.color-modes = lib.mkDefault true;
      };

      themes."catppuccin-${cfg.flavor}" =
        lib.importTOML "${sources.helix}/themes/${subdir}/catppuccin_${cfg.flavor}.toml";
    };
  };
}

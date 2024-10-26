{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.zed;
in

{
  options.catppuccin.zed = catppuccinLib.mkCatppuccinOption { name = "zed"; } // {
    italics = lib.mkEnableOption "the italicized version of theme" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      extensions = [ "catppuccin" ];

      userSettings.theme = {
        light = "Catppuccin " + cfg.flavor + lib.optionalString cfg.italics " - No Italic";
        dark = "Catppuccin" + cfg.flavor + lib.optionalString cfg.italics " - No Italic";
      };
    };
  };
}

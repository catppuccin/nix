{ config, lib, ... }:
let
  cfg = config.catppuccin.zed;
  enable = cfg.enable && config.programs.zed-editor.enable;
in
{
  options.catppuccin.zed = lib.ctp.mkCatppuccinOpt { name = "zed"; } // {
    italics = lib.mkEnableOption "the italicized version of theme" // {
      default = true;
    };
  };

  config = lib.mkIf enable {
    programs.zed-editor = {
      extensions = [ "catppuccin" ];

      userSettings.theme = {
        light = "Catppuccin " + cfg.flavor + lib.optionalString cfg.italics " - No Italic";
        dark = "Catppuccin" + cfg.flavor + lib.optionalString cfg.italics " - No Italic";
      };
    };
  };
}

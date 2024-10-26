{ config, lib, ... }:
let
  cfg = config.programs.zed-editor.catppuccin;
  enable = cfg.enable && config.programs.zed-editor.enable;
in
{
  options.programs.zed-editor.catppuccin = lib.ctp.mkCatppuccinOpt { name = "zed-editor"; } // {
    noItalics = lib.mkEnableOption "no italics version of theme";
  };

  config = lib.mkIf enable {
    programs.zed-editor = {
      extensions = [ "catppuccin" ];

      userSettings.theme = {
        light = "Catppuccin ${cfg.flavor}${lib.optionalString cfg.noItalics " - No Italic"}";
        dark = "Catppuccin ${cfg.flavor}${lib.optionalString cfg.noItalics " - No Italic"}";
      };
    };
  };
}

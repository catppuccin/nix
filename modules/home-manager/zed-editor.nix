{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.zed;
in

{
  options.catppuccin.zed =
    catppuccinLib.mkCatppuccinOption {
      name = "zed";
      darkLightSupport = true;
    }
    // {
      italics = lib.mkEnableOption "the italicized version of theme" // {
        default = true;
      };
    };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      extensions = [ "catppuccin" ];

      userSettings.theme = {
        light =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.lightFlavor
          + lib.optionalString (!cfg.italics) " - No Italics";
        dark =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.darkFlavor
          + lib.optionalString (!cfg.italics) " - No Italics";
      };
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zed;
  enable = cfg.enable && config.programs.zed-editor.enable;

  accent = if cfg.accent == "mauve" then "" else " (${cfg.accent})";
in

{
  options.catppuccin.zed =
    catppuccinLib.mkCatppuccinOption {
      name = "zed";
      accentSupport = true;
    }
    // {
      italics = lib.mkEnableOption "the italicized version of theme" // {
        default = true;
      };
    };

  config = lib.mkIf enable {
    programs.zed-editor = {
      userSettings.theme = {
        light =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.flavor
          + accent
          + lib.optionalString (!cfg.italics) " - No Italics";
        dark =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.flavor
          + accent
          + lib.optionalString (!cfg.italics) " - No Italics";
      };
    };

    xdg.configFile = {
      "zed/themes/catppuccin.json".source = "${sources.zed}/catppuccin-${
        lib.optionalString (!cfg.italics) "no-italics-"
      }${cfg.accent}.json";
    };
  };
}

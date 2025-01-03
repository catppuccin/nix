{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zed;
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

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      userSettings.theme = {
        light =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.flavor
          + " ("
          + cfg.accent
          + ")"
          + lib.optionalString (!cfg.italics) " - No Italics";
        dark =
          "Catppuccin "
          + catppuccinLib.mkUpper cfg.flavor
          + " ("
          + cfg.accent
          + ")"
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

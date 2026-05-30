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
      darkLightSupport = true;
    }
    // {
      italics = lib.mkEnableOption "the italicized version of theme" // {
        default = true;
      };

      icons = catppuccinLib.mkCatppuccinOption {
        name = "zed icons";
      };
    };

  config = lib.mkIf enable {
    programs.zed-editor = {
      extensions = lib.optionals cfg.icons.enable [ "catppuccin-icons" ];
      userSettings = {
        icon_theme = lib.mkIf cfg.icons.enable (
          "Catppuccin " + (catppuccinLib.mkFlavorName cfg.icons.flavor)
        );
        theme = {
          light =
            "Catppuccin "
            + (catppuccinLib.mkFlavorName cfg.lightFlavor)
            + accent
            + lib.optionalString (!cfg.italics) " - No Italics";
          dark =
            "Catppuccin "
            + (catppuccinLib.mkFlavorName cfg.darkFlavor)
            + accent
            + lib.optionalString (!cfg.italics) " - No Italics";
        };
      };
    };

    xdg.configFile = {
      "zed/themes/catppuccin.json".source = "${sources.zed}/catppuccin-${
        lib.optionalString (!cfg.italics) "no-italics-"
      }${cfg.accent}.json";
    };
  };
}

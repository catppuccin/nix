{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.ghostty;
  enable = cfg.enable && config.programs.ghostty.enable;

  lightThemeName = "catppuccin-${cfg.lightFlavor}";
  darkThemeName = "catppuccin-${cfg.darkFlavor}";
in
{
  options.catppuccin.ghostty = catppuccinLib.mkCatppuccinOption {
    name = "ghostty";
    darkLightSupport = true;
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "ghostty/themes/${lightThemeName}".source = "${sources.ghostty}/${lightThemeName}.conf";
    }
    // lib.optionalAttrs (lightThemeName != darkThemeName) {
      "ghostty/themes/${darkThemeName}".source = "${sources.ghostty}/${darkThemeName}.conf";
    };

    programs.ghostty = {
      settings = {
        theme = "light:${lightThemeName},dark:${darkThemeName}";
      };
    };
  };
}

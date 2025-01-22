{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.ghostty;
  themeName = "catppuccin-${cfg.flavor}";
  enable = cfg.enable && config.programs.ghostty.enable;
in
{
  options.catppuccin.ghostty = catppuccinLib.mkCatppuccinOption { name = "ghostty"; };

  config = lib.mkIf enable {
    xdg.configFile = {
      "ghostty/themes/${themeName}".source = "${sources.ghostty}/${themeName}.conf";
    };

    programs.ghostty = {
      settings = {
        theme = "light:${themeName},dark:${themeName}";
      };
    };
  };
}

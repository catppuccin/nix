{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.btop.catppuccin;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavor}.theme";
  themePath = "/themes/${themeFile}";
  theme = sources.btop + themePath;
in

{
  options.programs.btop.catppuccin = catppuccinLib.mkCatppuccinOption { name = "btop"; };

  config = lib.mkIf enable {
    xdg.configFile = {
      "btop${themePath}".source = theme;
    };

    programs.btop = {
      settings = {
        color_theme = themeFile;
      };
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.btop;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavor}.theme";
  themePath = "/themes/${themeFile}";
  theme = sources.btop + themePath;
in

{
  options.catppuccin.btop = catppuccinLib.mkCatppuccinOption { name = "btop"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "btop"
      "catppuccin"
    ];
    to = "btop";
  };

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

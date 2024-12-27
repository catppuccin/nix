{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.btop;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavor}.theme";
  theme = sources.btop + "/${themeFile}";
in

{
  options.catppuccin.btop = catppuccinLib.mkCatppuccinOption { name = "btop"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "btop"
      "catppuccin"
    ];
    to = "btop";
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "btop/themes/${themeFile}".source = theme;
    };

    programs.btop = {
      settings = {
        color_theme = themeFile;
      };
    };
  };
}

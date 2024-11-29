{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.btop.catppuccin;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavor}.theme";
  theme = sources.btop + "/${themeFile}";
in
{
  options.programs.btop.catppuccin = lib.ctp.mkCatppuccinOpt { name = "btop"; };

  config = lib.mkIf enable {
    xdg.configFile."btop/themes/${themeFile}".source = theme;

    programs.btop.settings.color_theme = themeFile;
  };
}

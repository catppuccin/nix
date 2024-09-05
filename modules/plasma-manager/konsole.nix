{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.konsole.catppuccin;
  enable = cfg.enable && config.programs.konsole.enable;
  themeName = "catppuccin-${cfg.flavor}";
in
{
  options.programs.konsole.catppuccin = lib.ctp.mkCatppuccinOpt { name = "konsole"; };

  config = lib.mkIf enable {
    programs.konsole.customColorSchemes.${themeName} = "${sources.konsole}/themes/${themeName}.colorscheme";
  };
}

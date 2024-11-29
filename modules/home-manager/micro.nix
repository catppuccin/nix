{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.micro.catppuccin;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "catppuccin-${cfg.flavor}.micro";
in
{
  options.programs.micro.catppuccin = lib.ctp.mkCatppuccinOpt { name = "micro"; };

  config = lib.mkIf enable {
    programs.micro.settings.colorscheme = lib.removeSuffix ".micro" themePath;

    xdg.configFile."micro/colorschemes/${themePath}".source = "${sources.micro}/${themePath}";
  };
}

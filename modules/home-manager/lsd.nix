{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.lsd;
  enable = cfg.enable && config.programs.lsd.enable;
in

{
  options.catppuccin.lsd = catppuccinLib.mkCatppuccinOption { name = "lsd"; };

  config = lib.mkIf enable {
    xdg.configFile = {
      "lsd/colors.yaml".source = "${sources.lsd}/catppuccin-${cfg.flavor}/colors.yaml";
    };
    programs.lsd.settings.color.theme = "custom";
  };
}

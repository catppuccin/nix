{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.micro;
  enable = config.catppuccin._enable && cfg.enable && config.programs.micro.enable;

  themePath =
    "catppuccin-${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent" + ".micro";
in

{
  options.catppuccin.micro = catppuccinLib.mkCatppuccinOption { name = "micro"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  config = lib.mkIf enable {
    programs.micro = {
      settings = {
        colorscheme = lib.removeSuffix ".micro" themePath;
      };
    };

    xdg.configFile = {
      "micro/colorschemes/${themePath}".source = "${sources.micro}/${themePath}";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cava;
  flavor = "${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
  enable = config.catppuccin._enable && cfg.enable && config.programs.cava.enable;
in

{
  options.catppuccin.cava = catppuccinLib.mkCatppuccinOption { name = "cava"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  config = lib.mkIf enable {
    xdg.configFile."cava/themes/catppuccin".source = sources.cava + "/${flavor}.cava";
    programs.cava.settings.color.theme = "catppuccin";
  };
}

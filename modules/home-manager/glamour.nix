{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.glamour;
in

{
  options.catppuccin.glamour = catppuccinLib.mkCatppuccinOption { name = "glamour"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    home.sessionVariables = {
      GLAMOUR_STYLE = "${sources.glamour}/catppuccin-${cfg.flavor}.json";
    };
  };
}

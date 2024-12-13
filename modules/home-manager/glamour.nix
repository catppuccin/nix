{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.glamour.catppuccin;
in

{
  options.programs.glamour.catppuccin = catppuccinLib.mkCatppuccinOption { name = "glamour"; };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GLAMOUR_STYLE = "${sources.glamour}/themes/catppuccin-${cfg.flavor}.json";
    };
  };
}

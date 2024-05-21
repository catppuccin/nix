{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.glamour.catppuccin;
  inherit (cfg) enable;
in
{
  options.programs.glamour.catppuccin = lib.ctp.mkCatppuccinOpt "glamour";

  config = {
    home.sessionVariables = lib.mkIf enable {
      GLAMOUR_STYLE = "${sources.glamour}/themes/catppuccin-${cfg.flavour}.json";
    };
  };
}

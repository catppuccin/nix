{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.glamour.catppuccin;
  inherit (cfg) enable;
in
{
  options.programs.glamour.catppuccin = lib.ctp.mkCatppuccinOpt { name = "glamour"; };

  config = {
    home.sessionVariables = lib.mkIf enable {
      GLAMOUR_STYLE = "${sources.glamour}/catppuccin-${cfg.flavor}.json";
    };
  };
}

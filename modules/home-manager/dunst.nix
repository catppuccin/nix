{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.services.dunst.catppuccin;
  enable = cfg.enable && config.services.dunst.enable;
in
{
  options.services.dunst.catppuccin = lib.ctp.mkCatppuccinOpt "dunst";

  config.services.dunst = lib.mkIf enable {
    settings = lib.ctp.fromINI (sources.dunst + "/themes/${cfg.flavor}.conf");
  };
}

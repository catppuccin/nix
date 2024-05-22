{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.swaylock.catppuccin;
  enable = cfg.enable && config.programs.swaylock.enable;
in
{
  options.programs.swaylock.catppuccin = lib.ctp.mkCatppuccinOpt "swaylock";

  config = lib.mkIf enable {
    programs.swaylock.settings = lib.ctp.fromINI (sources.swaylock + "/themes/${cfg.flavor}.conf");
  };
}

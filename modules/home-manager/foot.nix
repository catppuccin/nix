{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.foot.catppuccin;
  enable = cfg.enable && config.programs.foot.enable;
in
{
  options.programs.foot.catppuccin = lib.ctp.mkCatppuccinOpt { name = "foot"; };

  config.programs.foot = lib.mkIf enable {
    settings.main.include = sources.foot + "/catppuccin-${cfg.flavor}.ini";
  };
}

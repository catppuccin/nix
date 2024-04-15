{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.foot.catppuccin;
  enable = cfg.enable && config.programs.foot.enable;
  theme = lib.ctp.fromINI (sources.foot + /catppuccin-${cfg.flavour}.ini);
in
{
  options.programs.foot.catppuccin = lib.ctp.mkCatppuccinOpt "foot";

  config.programs.foot = lib.mkIf enable { settings = theme; };
}

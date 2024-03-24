{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.imv.catppuccin;
  enable = cfg.enable && config.programs.imv.enable;
in
{
  options.programs.imv.catppuccin =
    lib.ctp.mkCatppuccinOpt "imv";

  config.programs.imv.settings = lib.mkIf enable
    (lib.ctp.fromINI (sources.imv + /themes/${cfg.flavour}.config));
}

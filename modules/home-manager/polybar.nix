{ config
, lib
, sources
, ...
}:
let
  cfg = config.services.polybar.catppuccin;
  enable = cfg.enable && config.services.polybar.enable;
in
{
  options.services.polybar.catppuccin =
    lib.ctp.mkCatppuccinOpt "polybar";

  config.services.polybar.extraConfig = lib.mkIf enable
    (builtins.readFile "${sources.polybar}/themes/${cfg.flavour}.ini");
}

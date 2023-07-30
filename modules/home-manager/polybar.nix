{ config
, lib
, inputs
, ...
}:
let
  cfg = config.services.polybar.catppuccin;
  enable = cfg.enable && config.services.polybar.enable;
in
{
  options.services.polybar.catppuccin =
    lib.ctp.mkCatppuccinOpt "polybar" config;

  config.services.polybar.extraConfig = lib.mkIf enable
    (builtins.readFile "${inputs.polybar}/themes/${cfg.flavour}.ini");
}

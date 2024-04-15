{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.cava.catppuccin;
  enable = cfg.enable && config.programs.cava.enable;
in
{
  options.programs.cava.catppuccin =
    lib.ctp.mkCatppuccinOpt "cava";

  config.programs.cava = lib.mkIf enable {
    settings = lib.ctp.fromINIRaw (sources.cava + /themes/${cfg.flavour}.cava);
  };
}

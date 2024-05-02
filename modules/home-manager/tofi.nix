{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.tofi.catppuccin;
  enable = cfg.enable && config.programs.tofi.enable;
in
{
  options.programs.tofi.catppuccin =
    lib.ctp.mkCatppuccinOpt "tofi";

  config.programs.tofi = lib.mkIf enable {
    settings = lib.ctp.fromINI (sources.tofi + /catppuccin-${cfg.flavour});
  };
}

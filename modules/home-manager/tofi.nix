{ config
, lib
, ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.tofi.catppuccin;
  enable = cfg.enable && config.programs.tofi.enable;

  # `programs.tofi` was added in 24.05 and not backported
  # TODO: remove when 24.05 is stable
  minVersion = "24.05";
in
{
  options.programs.tofi = lib.ctp.mkVersionedOpts minVersion {
    catppuccin = lib.ctp.mkCatppuccinOpt "tofi";
  };

  config.programs.tofi = lib.mkIf enable {
    settings = lib.ctp.fromINI (sources.tofi + /catppuccin-${cfg.flavour});
  };
}

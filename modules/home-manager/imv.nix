{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.imv;
  enable = cfg.enable && config.programs.imv.enable;
in
{
  options.catppuccin.imv = lib.ctp.mkCatppuccinOpt { name = "imv"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "imv"
      "catppuccin"
    ];
    to = "imv";
  };

  config.programs.imv.settings = lib.mkIf enable (
    lib.ctp.fromINI (sources.imv + "/themes/${cfg.flavor}.config")
  );
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.imv.catppuccin;
  enable = cfg.enable && config.programs.imv.enable;
in
{
  options.programs.imv.catppuccin = lib.ctp.mkCatppuccinOption { name = "imv"; };

  config.programs.imv.settings = lib.mkIf enable (
    lib.ctp.fromINI (sources.imv + "/themes/${cfg.flavor}.config")
  );
}

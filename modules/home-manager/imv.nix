{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.imv;
in

{
  options.catppuccin.imv = catppuccinLib.mkCatppuccinOption { name = "imv"; };

  config = lib.mkIf cfg.enable {
    programs.imv = {
      settings = catppuccinLib.importINI (sources.imv + "/${cfg.flavor}.config");
    };
  };
}

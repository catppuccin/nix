{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.imv.catppuccin;
in

{
  options.programs.imv.catppuccin = catppuccinLib.mkCatppuccinOption { name = "imv"; };

  config = lib.mkIf cfg.enable {
    programs.imv = {
      settings = catppuccinLib.fromINI (sources.imv + "/themes/${cfg.flavor}.config");
    };
  };
}

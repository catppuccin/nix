{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.imv;
in

{
  options.catppuccin.imv = catppuccinLib.mkCatppuccinOption { name = "imv"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "imv"
      "catppuccin"
    ];
    to = "imv";
  };

  config = lib.mkIf cfg.enable {
    programs.imv = {
      settings = catppuccinLib.importINI (sources.imv + "/${cfg.flavor}.config");
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.imv;
in
{
  options.catppuccin.imv = catppuccinLib.mkCatppuccinOption { name = "imv"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "imv"
      "catppuccin"
    ];
    to = "imv";
  };

  config = lib.mkIf cfg.enable {
    programs.imv = {
      settings = catppuccinLib.fromINI (sources.imv + "/themes/${cfg.flavor}.config");
    };
  };
}

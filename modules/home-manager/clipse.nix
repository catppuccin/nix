{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.clipse;
  enable = config.catppuccin.enable && cfg.enable && config.services.clipse.enable;
in

{
  options.catppuccin.clipse = catppuccinLib.mkCatppuccinOption {
    name = "clipse";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    services.clipse = {
      theme = sources.clipse + "/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.json";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.hyprtoolkit;
in

{
  options.catppuccin.hyprtoolkit = catppuccinLib.mkCatppuccinOption {
    name = "hyprtoolkit";
    accentSupport = true;
    useGlobalEnable = false;
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hyprtoolkit.conf".source =
      sources.hyprtoolkit + "/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.conf";
  };
}

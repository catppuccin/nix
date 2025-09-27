{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.eza;
in

{
  options.catppuccin.eza = catppuccinLib.mkCatppuccinOption {
    name = "eza";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "eza/theme.yml".source = "${sources.eza}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
    };
  };
}

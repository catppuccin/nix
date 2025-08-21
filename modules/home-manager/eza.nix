{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.eza;
  theme = "${sources.eza}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in

{
  options.catppuccin.eza = catppuccinLib.mkCatppuccinOption {
    name = "eza";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      theme = catppuccinLib.importYAML theme;
    };
  };
}

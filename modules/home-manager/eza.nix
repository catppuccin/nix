{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.eza;
  enable = cfg.enable && config.programs.eza.enable;
in

{
  options.catppuccin.eza = catppuccinLib.mkCatppuccinOption {
    name = "eza";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "eza/theme.yml".source = "${sources.eza}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
    };
  };
}

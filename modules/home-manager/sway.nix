{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.sway;
  theme = "${sources.sway}/catppuccin-${cfg.flavor}";
in

{
  options.catppuccin.sway = catppuccinLib.mkCatppuccinOption { name = "sway"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    wayland.windowManager.sway = {
      extraConfigEarly = ''
        include ${theme}
      '';
    };
  };
}

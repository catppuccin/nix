{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.wayland.windowManager.sway.catppuccin;
  theme = "${sources.sway}/themes/catppuccin-${cfg.flavor}";
in

{
  options.wayland.windowManager.sway.catppuccin = catppuccinLib.mkCatppuccinOption { name = "sway"; };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      extraConfigEarly = ''
        include ${theme}
      '';
    };
  };
}

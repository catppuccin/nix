{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.wayland.windowManager.sway.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.sway.enable;
  theme = "${sources.sway}/catppuccin-${cfg.flavor}";
in
{
  options.wayland.windowManager.sway.catppuccin = lib.ctp.mkCatppuccinOpt { name = "sway"; };

  config = lib.mkIf enable {
    wayland.windowManager.sway.extraConfigEarly = ''
      include ${theme}
    '';
  };
}

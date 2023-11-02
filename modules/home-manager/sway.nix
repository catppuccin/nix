{ config
, lib
, sources
, ...
}:
let
  cfg = config.wayland.windowManager.sway.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.sway.enable;
  theme = "${sources.sway}/themes/catppuccin-${cfg.flavour}";
in
{
  options.wayland.windowManager.sway.catppuccin =
    lib.ctp.mkCatppuccinOpt "sway";

  config.wayland.windowManager.sway.extraConfigEarly =
    lib.mkIf enable ''
      include ${theme}
    '';
}

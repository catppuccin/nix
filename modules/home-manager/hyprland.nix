{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  options.wayland.windowManager.hyprland.catppuccin = lib.ctp.mkCatppuccinOpt "hyprland" // {
    accent = lib.ctp.mkAccentOpt "hyprland";
  };

  config.wayland.windowManager.hyprland.settings = lib.mkIf enable {
    source = [
      "${sources.hyprland}/themes/${cfg.flavour}.conf"
      (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
        $accent=''$${cfg.accent}
        $accentAlpha=''$${cfg.accent}Alpha
      '')
    ];
  };
}

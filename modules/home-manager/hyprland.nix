{ config
, lib
, sources
, ...
}:
let
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  options.wayland.windowManager.hyprland.catppuccin =
    lib.ctp.mkCatppuccinOpt "hyprland";

  # Because of how nix merges options and hyprland interprets options, sourcing
  # the file does not work. instead, parse the theme and put it in settings so
  # the variables appear early enough in the file to be applied properly.
  config.wayland.windowManager.hyprland.settings = lib.mkIf enable
    (lib.ctp.fromINI (sources.hyprland + /themes/${cfg.flavour}.conf));
}

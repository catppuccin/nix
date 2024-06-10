{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
  inherit (config.gtk.catppuccin) cursor;
in
{
  options.wayland.windowManager.hyprland.catppuccin = lib.ctp.mkCatppuccinOpt "hyprland" // {
    accent = lib.ctp.mkAccentOpt "hyprland";
  };

  config = lib.mkIf enable {
    home.sessionVariables = lib.mkIf cursor.enable {
      HYPRCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "catppuccin-${cursor.flavor}-${cursor.accent}-cursors";
    };

    wayland.windowManager.hyprland.settings = {
      source =
        [
          "${sources.hyprland}/themes/${cfg.flavor}.conf"
          (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
            $accent=''$${cfg.accent}
            $accentAlpha=''$${cfg.accent}Alpha
          '')
        ]
        ++ lib.optionals cursor.enable [
          (builtins.toFile "hyprland-cursors.conf" ''
            env = HYPRCURSOR_THEME,MyCursor
            env = HYPRCURSOR_SIZE,24
          '')
        ];
    };
  };
}

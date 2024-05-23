{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
  inherit (config.catppuccin) pointerCursor;
in
{
  options.wayland.windowManager.hyprland.catppuccin = lib.ctp.mkCatppuccinOpt "hyprland" // {
    accent = lib.ctp.mkAccentOpt "hyprland";
  };

  config = lib.mkIf enable {
    home.sessionVariables = lib.mkIf pointerCursor.enable {
      HYPRCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "catppuccin-${pointerCursor.flavor}-${pointerCursor.accent}-cursors";
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
        ++ lib.optionals pointerCursor.enable [
          (builtins.toFile "hyprland-cursors.conf" ''
            env = HYPRCURSOR_THEME,MyCursor
            env = HYPRCURSOR_SIZE,24
          '')
        ];
    };
  };
}

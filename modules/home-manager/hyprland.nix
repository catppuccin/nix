{ config, lib, ... }:
let
  inherit (config.catppuccin) sources pointerCursor;
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  options.wayland.windowManager.hyprland.catppuccin =
    lib.ctp.mkCatppuccinOpt { name = "hyprland"; }
    // {
      accent = lib.ctp.mkAccentOpt "hyprland";
    };

  config = lib.mkIf enable {
    home.sessionVariables = lib.mkIf pointerCursor.enable {
      HYPRCURSOR_SIZE = config.home.pointerCursor.size;
      HYPRCURSOR_THEME = "catppuccin-${pointerCursor.flavor}-${pointerCursor.accent}-cursors";
    };

    wayland.windowManager.hyprland.settings = {
      source = [
        "${sources.hyprland}/${cfg.flavor}.conf"
        # Define accents in file to ensure they appear before user vars
        (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
          $accent = ''$${cfg.accent}
          $accentAlpha = ''$${cfg.accent}Alpha
        '')
      ];
    };
  };
}

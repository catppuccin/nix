{ config, lib, ... }:
let
  inherit (config.catppuccin) sources cursors;
  cfg = config.catppuccin.hyprland;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  options.catppuccin.hyprland = lib.ctp.mkCatppuccinOpt { name = "hyprland"; } // {
    accent = lib.ctp.mkAccentOpt "hyprland";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "wayland"
      "windowManager"
      "hyprland"
      "catppuccin"
    ];
    to = "hyprland";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    home.sessionVariables = lib.mkIf cursors.enable {
      HYPRCURSOR_SIZE = config.home.pointerCursor.size;
      HYPRCURSOR_THEME = "catppuccin-${cursors.flavor}-${cursors.accent}-cursors";
    };

    wayland.windowManager.hyprland.settings = {
      source = [
        "${sources.hyprland}/themes/${cfg.flavor}.conf"
        # Define accents in file to ensure they appear before user vars
        (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
          $accent = ''$${cfg.accent}
          $accentAlpha = ''$${cfg.accent}Alpha
        '')
      ];
    };
  };
}

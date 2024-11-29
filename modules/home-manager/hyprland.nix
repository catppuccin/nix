{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources cursors;
  cfg = config.catppuccin.hyprland;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in

{
  options.catppuccin.hyprland = catppuccinLib.mkCatppuccinOption {
    name = "hyprland";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
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

    wayland.windowManager.hyprland = {
      settings = {
        source = [
          "${sources.hyprland}/${cfg.flavor}.conf"

          # Define accents in file to ensure they appear before user vars
          (pkgs.writeText "hyprland-${cfg.accent}-accent.conf" ''
            $accent = ''$${cfg.accent}
            $accentAlpha = ''$${cfg.accent}Alpha
          '')
        ];
      };
    };
  };
}

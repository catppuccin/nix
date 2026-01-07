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
  enable = config.catppuccin._enable && cfg.enable && config.wayland.windowManager.hyprland.enable;

  themeFile = pkgs.runCommandLocal "catppuccin-hyprland-${cfg.flavor}-${cfg.accent}.lua" { } ''
    install -m644 ${sources.hyprland}/catppuccin-${cfg.flavor}.lua $out
    sed -i 's|^return M$|M.accent = M.${cfg.accent}\nM.accentAlpha = M.${cfg.accent}Alpha\n\n&|' $out
  '';
in

{
  options.catppuccin.hyprland = catppuccinLib.mkCatppuccinOption {
    name = "hyprland";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    home.sessionVariables = lib.mkIf cursors.enable {
      HYPRCURSOR_SIZE = config.home.pointerCursor.size;
      HYPRCURSOR_THEME = "catppuccin-${cursors.flavor}-${cursors.accent}-cursors";
    };

    xdg.configFile."hypr/themes/catppuccin.lua".source = themeFile;

    wayland.windowManager.hyprland.settings = {
      colors._var = lib.generators.mkLuaInline "require('themes.catppuccin')";
    };
  };
}

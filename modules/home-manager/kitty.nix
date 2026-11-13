{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.catppuccin.kitty;

  themeFile = flavor: "Catppuccin-${lib.toSentenceCase flavor}";
  themePath = flavor: "${pkgs.kitty-themes}/share/kitty-themes/themes/${themeFile flavor}.conf";
in

{
  options.catppuccin.kitty = catppuccinLib.mkCatppuccinOption {
    name = "kitty";
    darkLightSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.kitty = {
      themeFile = themeFile cfg.darkFlavor;
    };

    # kitty switches to these when the OS color scheme changes
    # https://sw.kovidgoyal.net/kitty/kittens/themes/#change-color-themes-automatically-when-the-os-switches-between-light-and-dark
    xdg.configFile = lib.mkIf (config.programs.kitty.enable && cfg.lightFlavor != cfg.darkFlavor) {
      "kitty/light-theme.auto.conf".source = themePath cfg.lightFlavor;
      "kitty/dark-theme.auto.conf".source = themePath cfg.darkFlavor;
      # GNOME reports "no preference" instead of light in light mode
      # https://github.com/kovidgoyal/kitty/issues/8448#issuecomment-2735095371
      "kitty/no-preference-theme.auto.conf".source = themePath cfg.lightFlavor;
    };
  };
}

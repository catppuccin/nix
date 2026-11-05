{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.ghostty;
  themeName = "catppuccin-${cfg.flavor}";
  enable = config.catppuccin.enable && cfg.enable && config.programs.ghostty.enable;
in
{
  options.catppuccin.ghostty = catppuccinLib.mkCatppuccinOption {
    name = "ghostty";
    fontSupport = true;
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "ghostty/themes/${themeName}".source = "${sources.ghostty}/${themeName}.conf";
    };

    programs.ghostty = {
      settings = {
        theme = "light:${themeName},dark:${themeName}";
        font-family = lib.mkIf (cfg.font != null) (lib.mkDefault cfg.font);
        font-size = lib.mkIf (cfg.fontSize != null) (lib.mkDefault cfg.fontSize);
      };
    };
  };
}

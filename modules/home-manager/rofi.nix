{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.rofi.catppuccin;
  enable = cfg.enable && config.programs.rofi.enable;
in
{
  options.programs.rofi.catppuccin = lib.ctp.mkCatppuccinOption { name = "rofi"; };

  config.programs.rofi = lib.mkIf enable {
    theme = {
      "@theme" = builtins.path {
        name = "catppuccin-${cfg.flavor}.rasi";
        path = "${sources.rofi}/basic/.local/share/rofi/themes/catppuccin-${cfg.flavor}.rasi";
      };
    };
  };
}

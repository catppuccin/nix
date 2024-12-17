{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.rofi.catppuccin;
in

{
  options.programs.rofi.catppuccin = catppuccinLib.mkCatppuccinOption { name = "rofi"; };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      theme = {
        "@theme" = builtins.path {
          name = "catppuccin-${cfg.flavor}.rasi";
          path = "${sources.rofi}/basic/.local/share/rofi/themes/catppuccin-${cfg.flavor}.rasi";
        };
      };
    };
  };
}

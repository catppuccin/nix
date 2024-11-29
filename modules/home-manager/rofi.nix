{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rofi;
in

{
  options.catppuccin.rofi = catppuccinLib.mkCatppuccinOption { name = "rofi"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "rofi"
      "catppuccin"
    ];
    to = "rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      theme = {
        "@theme" = builtins.path {
          name = "catppuccin-${cfg.flavor}.rasi";
          path = "${sources.rofi}/catppuccin-${cfg.flavor}.rasi";
        };
      };
    };
  };
}

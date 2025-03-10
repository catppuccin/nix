{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rofi;
  enable = config.programs.rofi.enable && cfg.enable;
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

  config = lib.mkIf enable {
    programs.rofi = {
      theme = {
        "@theme" = "catppuccin-default";
        "@import" = "catppuccin-${cfg.flavor}";
      };
    };

    xdg.dataFile = {
      "rofi/themes/catppuccin-default.rasi" = {
        source = sources.rofi + "/catppuccin-default.rasi";
      };
      "rofi/themes/catppuccin-${cfg.flavor}.rasi" = {
        source = sources.rofi + "/themes/catppuccin-${cfg.flavor}.rasi";
      };
    };
  };
}

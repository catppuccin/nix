{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rofi;
  enable = cfg.enable && config.programs.rofi.enable;
in
{
  options.catppuccin.rofi = lib.ctp.mkCatppuccinOpt { name = "rofi"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "rofi"
      "catppuccin"
    ];
    to = "rofi";
  };

  config.programs.rofi = lib.mkIf enable {
    theme = {
      "@theme" = builtins.path {
        name = "catppuccin-${cfg.flavor}.rasi";
        path = "${sources.rofi}/basic/.local/share/rofi/themes/catppuccin-${cfg.flavor}.rasi";
      };
    };
  };
}

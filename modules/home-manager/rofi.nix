{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.rofi.catppuccin;
  enable = cfg.enable && config.programs.rofi.enable;
in
{
  options.programs.rofi.catppuccin =
    lib.ctp.mkCatppuccinOpt "rofi";

  config.programs.rofi = lib.mkIf enable {
    theme = {
      "@theme" = builtins.path {
        name = "catppuccin-${cfg.flavour}.rasi";
        path = "${sources.rofi}/basic/.local/share/rofi/themes/catppuccin-${cfg.flavour}.rasi";
      };
    };
  };
}

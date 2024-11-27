{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.programs.kitty.catppuccin;
  enable = cfg.enable && config.programs.kitty.enable;
in
{
  options.programs.kitty.catppuccin = catppuccinLib.mkCatppuccinOption { name = "kitty"; };

  config = lib.mkIf enable {
    programs.kitty.themeFile = "Catppuccin-${catppuccinLib.mkUpper cfg.flavor}";
  };
}

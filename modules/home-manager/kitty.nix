{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.programs.kitty.catppuccin;
in

{
  options.programs.kitty.catppuccin = catppuccinLib.mkCatppuccinOption { name = "kitty"; };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      themeFile = "Catppuccin-${catppuccinLib.mkUpper cfg.flavor}";
    };
  };
}

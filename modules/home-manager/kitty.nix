{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.kitty;
in

{
  options.catppuccin.kitty = catppuccinLib.mkCatppuccinOption { name = "kitty"; };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      themeFile = "Catppuccin-${lib.toSentenceCase cfg.flavor}";
    };
  };
}

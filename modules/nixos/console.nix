{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.console.catppuccin;

  enable = cfg.enable && config.console.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in

{
  options.console.catppuccin = catppuccinLib.mkCatppuccinOption { name = "console"; };

  config = lib.mkIf enable {
    # Manually populate with colors from catppuccin/tty
    # Make sure to strip initial # from hex codes
    console.colors = map (color: (lib.substring 1 6 palette.${color}.hex)) [
      "base"
      "red"
      "green"
      "yellow"
      "blue"
      "pink"
      "teal"
      "subtext1"

      "surface2"
      "red"
      "green"
      "yellow"
      "blue"
      "pink"
      "teal"
      "subtext0"
    ];
  };
}

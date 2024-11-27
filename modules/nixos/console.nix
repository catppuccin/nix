{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.console.catppuccin;
  enable = cfg.enable && config.console.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in
{
  options.console.catppuccin = lib.ctp.mkCatppuccinOption { name = "console"; };

  config.console.colors = lib.mkIf enable (
    # Manually populate with colors from catppuccin/tty
    # Make sure to strip initial # from hex codes
    map (color: (builtins.substring 1 6 palette.${color}.hex)) [
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
    ]
  );
}

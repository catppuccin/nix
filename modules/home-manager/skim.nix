{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.skim.catppuccin;
  enable = cfg.enable && config.programs.skim.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavour}.colors;
in
{
  options.programs.skim.catppuccin = lib.ctp.mkCatppuccinOpt "skim";

  config.programs.skim = lib.mkIf enable {
    defaultOptions = [
      "--color=fg:${palette.text.hex},bg:${palette.base.hex},matched:${palette.surface0.hex},matched_bg:${palette.flamingo.hex},current:${palette.text.hex},current_bg:${palette.surface1.hex},current_match:${palette.base.hex},current_match_bg:${palette.rosewater.hex},spinner:${palette.green.hex},info:${palette.mauve.hex},prompt:${palette.blue.hex},cursor:${palette.red.hex},selected:${palette.maroon.hex},header:${palette.teal.hex},border:${palette.overlay0.hex}"
    ];
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.skim;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in

{
  options.catppuccin.skim = catppuccinLib.mkCatppuccinOption { name = "skim"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "skim"
      "catppuccin"
    ];
    to = "skim";
  };

  config = lib.mkIf cfg.enable {
    programs.skim = {
      defaultOptions = [
        "--color=fg:${palette.text.hex},bg:${palette.base.hex},matched:${palette.surface0.hex},matched_bg:${palette.flamingo.hex},current:${palette.text.hex},current_bg:${palette.surface1.hex},current_match:${palette.base.hex},current_match_bg:${palette.rosewater.hex},spinner:${palette.green.hex},info:${palette.mauve.hex},prompt:${palette.blue.hex},cursor:${palette.red.hex},selected:${palette.maroon.hex},header:${palette.teal.hex},border:${palette.overlay0.hex}"
      ];
    };
  };
}

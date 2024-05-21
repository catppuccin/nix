{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.fzf.catppuccin;
  enable = cfg.enable && config.programs.fzf.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavour}.colors;
in
{
  options.programs.fzf.catppuccin = lib.ctp.mkCatppuccinOpt "fzf";

  config.programs.fzf.colors =
    lib.mkIf enable
      # Manually populate with colors from catppuccin/fzf
      # The ordering is meant to match the order of catppuccin/fzf to make comparison easier
      (
        lib.attrsets.mapAttrs (_: color: palette.${color}.hex) {
          "bg+" = "surface0";
          bg = "base";
          spinner = "rosewater";
          hl = "red";
          fg = "text";
          header = "red";
          info = "mauve";
          pointer = "rosewater";
          marker = "rosewater";
          "fg+" = "text";
          prompt = "mauve";
          "hl+" = "red";
        }
      );
}

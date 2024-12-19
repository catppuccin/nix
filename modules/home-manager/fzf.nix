{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fzf;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;

  # Manually populate with colors from catppuccin/fzf
  # The ordering is meant to match the order of catppuccin/fzf to make comparison easier
  colors = lib.attrsets.mapAttrs (_: color: palette.${color}.hex) {
    "bg+" = "surface0";
    bg = "base";
    spinner = "rosewater";
    hl = cfg.accent;
    fg = "text";
    header = cfg.accent;
    info = cfg.accent;
    pointer = cfg.accent;
    marker = cfg.accent;
    "fg+" = "text";
    prompt = cfg.accent;
    "hl+" = cfg.accent;
  };
in

{
  options.catppuccin.fzf = catppuccinLib.mkCatppuccinOption {
    name = "fzf";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "fzf"
      "catppuccin"
    ];
    to = "fzf";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      inherit colors;
    };
  };
}

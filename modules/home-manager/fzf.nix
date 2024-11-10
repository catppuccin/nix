{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fzf;
  enable = cfg.enable && config.programs.fzf.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in
{
  options.catppuccin.fzf = lib.ctp.mkCatppuccinOpt { name = "fzf"; } // {
    accent = lib.ctp.mkAccentOpt "fzf";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "fzf"
      "catppuccin"
    ];
    to = "fzf";
    accentSupport = true;
  };

  config.programs.fzf.colors =
    lib.mkIf enable
      # Manually populate with colors from catppuccin/fzf
      # The ordering is meant to match the order of catppuccin/fzf to make comparison easier
      (
        lib.attrsets.mapAttrs (_: color: palette.${color}.hex) {
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
        }
      );
}

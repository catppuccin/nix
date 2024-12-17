{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.gitui.catppuccin;
  enable = cfg.enable && config.programs.gitui.enable;
in
{
  options.programs.gitui.catppuccin = lib.ctp.mkCatppuccinOption { name = "gitui"; };

  config = lib.mkIf enable {
    programs.gitui.theme = builtins.path {
      name = "${cfg.flavor}.ron";
      path = "${sources.gitui}/themes/catppuccin-${cfg.flavor}.ron";
    };
  };
}

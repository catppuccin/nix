{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.gitui.catppuccin;
in

{
  options.programs.gitui.catppuccin = catppuccinLib.mkCatppuccinOption { name = "gitui"; };

  config = lib.mkIf cfg.enable {
    programs.gitui.theme = builtins.path {
      name = "${cfg.flavor}.ron";
      path = "${sources.gitui}/themes/catppuccin-${cfg.flavor}.ron";
    };
  };
}

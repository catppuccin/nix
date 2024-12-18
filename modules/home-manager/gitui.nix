{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gitui;
in
{
  options.catppuccin.gitui = catppuccinLib.mkCatppuccinOption { name = "gitui"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "gitui"
      "catppuccin"
    ];
    to = "gitui";
  };

  config = lib.mkIf cfg.enable {
    programs.gitui.theme = builtins.path {
      name = "${cfg.flavor}.ron";
      path = "${sources.gitui}/themes/catppuccin-${cfg.flavor}.ron";
    };
  };
}

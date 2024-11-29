{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gitui;
in

{
  options.catppuccin.gitui = catppuccinLib.mkCatppuccinOption { name = "gitui"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
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
      path = "${sources.gitui}/catppuccin-${cfg.flavor}.ron";
    };
  };
}

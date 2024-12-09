{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gitui;
  enable = cfg.enable && config.programs.gitui.enable;
in
{
  options.catppuccin.gitui = lib.ctp.mkCatppuccinOpt { name = "gitui"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "gitui"
      "catppuccin"
    ];
    to = "gitui";
  };

  config = lib.mkIf enable {
    programs.gitui.theme = builtins.path {
      name = "${cfg.flavor}.ron";
      path = "${sources.gitui}/themes/catppuccin-${cfg.flavor}.ron";
    };
  };
}

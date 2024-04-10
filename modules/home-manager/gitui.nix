{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.gitui.catppuccin;
  enable = cfg.enable && config.programs.gitui.enable;
in
{
  options.programs.gitui.catppuccin =
    lib.ctp.mkCatppuccinOpt "gitui";

  config = lib.mkIf enable {
    programs.gitui.theme = builtins.path {
      name = "${cfg.flavour}.ron";
      path = "${sources.gitui}/theme/${cfg.flavour}.ron";
    };
  };
}

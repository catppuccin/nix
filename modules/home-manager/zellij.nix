{ config, lib, ... }:
let
  cfg = config.programs.zellij.catppuccin;
  enable = cfg.enable && config.programs.zellij.enable;
  themeName = "catppuccin-${cfg.flavour}";
in
{
  options.programs.zellij.catppuccin = lib.ctp.mkCatppuccinOpt "zellij";

  config = lib.mkIf enable {
    programs.zellij.settings = {
      theme = themeName;
    };
  };
}

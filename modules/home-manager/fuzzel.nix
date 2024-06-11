{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.fuzzel.catppuccin;
  enable = cfg.enable && config.programs.fuzzel.enable;
in
{
  options.programs.fuzzel.catppuccin = lib.ctp.mkCatppuccinOpt "fuzzel";

  config = lib.mkIf enable {
    xdg.configFile."fuzzel/fuzzel.ini".source = "${sources.fuzzel}/themes/${cfg.flavor}.ini";
  };
}

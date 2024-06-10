{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.programs.yazi.catppuccin = lib.ctp.mkCatppuccinOpt "yazi";

  config = lib.mkIf enable {
    programs.yazi.theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavor}.toml";
  };
}

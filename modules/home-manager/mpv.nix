{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.mpv.catppuccin;
  enable = cfg.enable && config.programs.mpv.enable;
in
{
  options.programs.mpv.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "mpv";
    accentSupport = true;
  };

  config.programs.mpv = lib.mkIf enable {
    config.include = sources.mpv + "/themes/${cfg.flavor}/${cfg.accent}.conf";
  };
}

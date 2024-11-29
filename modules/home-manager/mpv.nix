{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp mkIf;
  cfg = config.programs.mpv.catppuccin;
  enable = cfg.enable && config.programs.mpv.enable;
in
{
  options.programs.mpv.catppuccin = ctp.mkCatppuccinOpt { name = "mpv"; } // {
    accent = ctp.mkAccentOpt "mpv";
  };

  config.programs.mpv = mkIf enable {
    config.include = sources.mpv + "/${cfg.flavor}/${cfg.accent}.conf";
  };
}

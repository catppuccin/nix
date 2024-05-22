{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.mpv.catppuccin;
  enable = cfg.enable && config.programs.mpv.enable;
  themeDir = sources.mpv + "/themes/${cfg.flavor}/${cfg.accent}";
in
{
  options.programs.mpv.catppuccin = lib.ctp.mkCatppuccinOpt "mpv" // {
    accent = lib.ctp.mkAccentOpt "mpv";
  };

  # Note that the theme is defined across multiple files
  config.programs.mpv = lib.mkIf enable {
    config = lib.ctp.fromINI (themeDir + "/mpv.conf");
    scriptOpts.stats = lib.ctp.fromINI (themeDir + "/script-opts/stats.conf");
  };
}

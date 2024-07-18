{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp mkIf;
  cfg = config.programs.mpv.catppuccin;
  enable = cfg.enable && config.programs.mpv.enable;
  themeDir = sources.mpv + "/themes/${cfg.flavor}/${cfg.accent}";
  uoscDir = sources.mpv + "/uosc/themes/${cfg.flavor}/${cfg.accent}";
in
{
  options.programs.mpv.catppuccin = ctp.mkCatppuccinOpt { name = "mpv"; } // {
    accent = ctp.mkAccentOpt "mpv";
  };

  # Note that the theme is defined across multiple files
  config.programs.mpv = mkIf enable {
    config = ctp.fromINI (themeDir + "/mpv.conf");
    scriptOpts = {
      stats = ctp.fromINI (themeDir + "/script-opts/stats.conf");
      uosc = ctp.fromINI (uoscDir + "/script-opts/uosc.conf");
    };
  };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp mkIf;
  cfg = config.catppuccin.mpv;
  enable = cfg.enable && config.programs.mpv.enable;
in
{
  options.catppuccin.mpv = ctp.mkCatppuccinOpt { name = "mpv"; } // {
    accent = ctp.mkAccentOpt "mpv";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "mpv"
      "catppuccin"
    ];
    to = "mpv";
    accentSupport = true;
  };

  config.programs.mpv = mkIf enable {
    config.include = sources.mpv + "/themes/${cfg.flavor}/${cfg.accent}.conf";
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.services.mako.catppuccin;
  enable = cfg.enable && config.services.mako.enable;
  theme = lib.ctp.fromINI (
    sources.mako + "/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}"
  );

  # Settings that need to be extracted and put in extraConfig
  extraConfigAttrs = lib.attrsets.getAttrs [ "urgency=high" ] theme;
in
{
  options.services.mako.catppuccin = lib.ctp.mkCatppuccinOpt { name = "mako"; } // {
    accent = lib.ctp.mkAccentOpt "mako";
  };

  # Will cause infinite recursion if config.services.mako is directly set as a whole
  config.services.mako = lib.mkIf enable {
    backgroundColor = theme.background-color;
    textColor = theme.text-color;
    borderColor = theme.border-color;
    progressColor = theme.progress-color;
    extraConfig = builtins.readFile (
      (pkgs.formats.ini { }).generate "mako-extra-config" extraConfigAttrs
    );
  };
}

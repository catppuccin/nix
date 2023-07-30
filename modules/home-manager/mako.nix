{ config
, pkgs
, lib
, sources
, ...
}:
let
  inherit (builtins) readFile;

  cfg = config.services.mako.catppuccin;
  enable = cfg.enable && config.services.mako.enable;
  theme = lib.ctp.fromINI pkgs (sources.mako + /src/${cfg.flavour});

  # Settings that need to be extracted and put in extraConfig
  extraConfigAttrs = lib.attrsets.getAttrs [ "urgency=high" ] theme;
in
{
  options.services.mako.catppuccin =
    lib.ctp.mkCatppuccinOpt "mako" config;

  # Will cause infinite recursion if config.services.mako is directly set as a whole
  config.services.mako = lib.mkIf enable {
    backgroundColor = theme.background-color;
    textColor = theme.text-color;
    borderColor = theme.border-color;
    progressColor = theme.progress-color;
    extraConfig = readFile ((pkgs.formats.ini { }).generate "mako-extra-config" extraConfigAttrs);
  };
}

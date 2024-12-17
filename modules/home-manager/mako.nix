{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.services.mako.catppuccin;
  theme = catppuccinLib.fromINI (
    sources.mako + "/themes/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}"
  );

  # Settings that need to be extracted and put in extraConfig
  extraConfigAttrs = lib.attrsets.getAttrs [ "urgency=high" ] theme;
in

{
  options.services.mako.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "mako";
    accentSupport = true;
  };

  # Will cause infinite recursion if config.services.mako is directly set as a whole
  config.services.mako = lib.mkIf cfg.enable {
    backgroundColor = theme.background-color;
    textColor = theme.text-color;
    borderColor = theme.border-color;
    progressColor = theme.progress-color;
    extraConfig = lib.fileContents (
      (pkgs.formats.ini { }).generate "mako-extra-config" extraConfigAttrs
    );
  };
}

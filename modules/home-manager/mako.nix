{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.mako;
  theme = catppuccinLib.importINI (
    sources.mako + "/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}"
  );

  # Settings that need to be extracted and put in extraConfig
  extraConfigAttrs = lib.attrsets.getAttrs [ "urgency=high" ] theme;
in

{
  options.catppuccin.mako = catppuccinLib.mkCatppuccinOption {
    name = "mako";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "services"
      "mako"
      "catppuccin"
    ];
    to = "mako";
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

{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.mako;
in

{
  options.catppuccin.mako = catppuccinLib.mkCatppuccinOption {
    name = "mako";
    accentSupport = true;
    fontSupport = true;
  };

  config.services.mako = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    settings = {
      include = sources.mako + "/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}";
      font = lib.mkIf (cfg.font != null) (
        lib.mkDefault "${cfg.font}${lib.optionalString (cfg.fontSize != null) " ${toString cfg.fontSize}"}"
      );
    };
  };
}

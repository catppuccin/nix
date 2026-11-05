{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.foot;
in

{
  options.catppuccin.foot = catppuccinLib.mkCatppuccinOption {
    name = "foot";
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.foot = {
      settings = {
        main = {
          include = sources.foot + "/static/catppuccin-${cfg.flavor}.ini";
          font = lib.mkIf (cfg.font != null) (
            lib.mkDefault "${cfg.font}${
              lib.optionalString (cfg.fontSize != null) ":size=${toString cfg.fontSize}"
            }"
          );
        };
      };
    };
  };
}

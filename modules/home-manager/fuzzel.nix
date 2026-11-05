{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fuzzel;
in

{
  options.catppuccin.fuzzel = catppuccinLib.mkCatppuccinOption {
    name = "fuzzel";
    accentSupport = true;
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.fuzzel = {
      settings = {
        main = {
          include = sources.fuzzel + "/catppuccin-${cfg.flavor}/${cfg.accent}.ini";
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

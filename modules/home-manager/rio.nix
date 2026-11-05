{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rio;
in

{
  options.catppuccin.rio = catppuccinLib.mkCatppuccinOption {
    name = "rio";
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.rio = {
      settings = lib.mkMerge [
        (lib.importTOML "${sources.rio}/catppuccin-${cfg.flavor}.toml")
        (lib.mkIf (cfg.font != null) {
          fonts.family = lib.mkDefault cfg.font;
        })
        (lib.mkIf (cfg.fontSize != null) {
          fonts.size = lib.mkDefault cfg.fontSize;
        })
      ];
    };
  };
}

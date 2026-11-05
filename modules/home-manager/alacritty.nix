{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.alacritty;
in

{
  options.catppuccin.alacritty = catppuccinLib.mkCatppuccinOption {
    name = "alacritty";
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.alacritty = {
      settings = {
        general.import = lib.mkBefore [ "${sources.alacritty}/catppuccin-${cfg.flavor}.toml" ];
        font = lib.mkMerge [
          (lib.mkIf (cfg.font != null) {
            normal.family = lib.mkDefault cfg.font;
          })
          (lib.mkIf (cfg.fontSize != null) {
            size = lib.mkDefault cfg.fontSize;
          })
        ];
      };
    };
  };
}

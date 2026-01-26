{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.alacritty;
in

{
  options.catppuccin.alacritty = catppuccinLib.mkCatppuccinOption { name = "alacritty"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.alacritty = {
      settings.general.import = lib.mkBefore [ "${sources.alacritty}/catppuccin-${cfg.flavor}.toml" ];
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.polybar;
in

{
  options.catppuccin.polybar = catppuccinLib.mkCatppuccinOption { name = "polybar"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    services.polybar = {
      extraConfig = lib.fileContents "${sources.polybar}/${cfg.flavor}.ini";
    };
  };
}

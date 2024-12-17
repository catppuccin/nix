{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.services.polybar.catppuccin;
in

{
  options.services.polybar.catppuccin = catppuccinLib.mkCatppuccinOption { name = "polybar"; };

  config = lib.mkIf cfg.enable {
    services.polybar = {
      extraConfig = lib.fileContents "${sources.polybar}/themes/${cfg.flavor}.ini";
    };
  };
}

{ catppuccinLib }: 
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.services.polybar.catppuccin;
  enable = cfg.enable && config.services.polybar.enable;
in
{
  options.services.polybar.catppuccin = catppuccinLib.mkCatppuccinOption { name = "polybar"; };

  config.services.polybar.extraConfig = lib.mkIf enable (
    builtins.readFile "${sources.polybar}/themes/${cfg.flavor}.ini"
  );
}

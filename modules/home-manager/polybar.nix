{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.services.polybar.catppuccin;
  enable = cfg.enable && config.services.polybar.enable;
in
{
  options.services.polybar.catppuccin = lib.ctp.mkCatppuccinOpt { name = "polybar"; };

  config.services.polybar.extraConfig = lib.mkIf enable (
    builtins.readFile "${sources.polybar}/${cfg.flavor}.ini"
  );
}

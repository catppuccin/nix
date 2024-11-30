{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.boot.plymouth.catppuccin;
  enable = cfg.enable && config.boot.plymouth.enable;
in
{
  options.boot.plymouth.catppuccin = catppuccinLib.mkCatppuccinOption { name = "plymouth"; };

  config.boot.plymouth = lib.mkIf enable {
    theme = "catppuccin-${cfg.flavor}";
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = cfg.flavor; }) ];
  };
}

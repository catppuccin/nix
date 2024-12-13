{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.boot.plymouth.catppuccin;
in

{
  options.boot.plymouth.catppuccin = catppuccinLib.mkCatppuccinOption { name = "plymouth"; };

  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      theme = "catppuccin-${cfg.flavor}";
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = cfg.flavor; }) ];
    };
  };
}

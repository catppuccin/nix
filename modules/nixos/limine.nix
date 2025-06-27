{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.limine;

  theme = sources.limine + "/catppuccin-${cfg.flavor}.conf";
in

{
  options.catppuccin.limine = catppuccinLib.mkCatppuccinOption { name = "limine"; };


  config = lib.mkIf cfg.enable {
    boot.loader.limine = {
      extraConfig = builtins.readFile theme;
      style.wallpapers = [];
    };
  };
}

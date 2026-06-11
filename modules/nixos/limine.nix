{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.limine;

  theme = sources.limine + "/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.conf";
in

{
  options.catppuccin.limine = catppuccinLib.mkCatppuccinOption {
    name = "limine";
    accentSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    boot.loader.limine = {
      extraConfig = lib.fileContents theme;
      style.wallpapers = [ ];
    };
  };
}

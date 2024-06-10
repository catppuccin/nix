{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.boot.loader.grub.catppuccin;
  enable = cfg.enable && config.boot.loader.grub.enable;
  theme = "${pkgs.catppuccin.override ({ variant = cfg.flavor; })}/grub";
in
{
  options.boot.loader.grub.catppuccin = ctp.mkCatppuccinOpt "grub";

  config.boot.loader.grub = mkIf enable {
    font = "${theme}/font.pf2";
    splashImage = "${theme}/background.png";
    inherit theme;
  };
}

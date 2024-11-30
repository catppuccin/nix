{ catppuccinLib }: 
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.boot.loader.grub.catppuccin;
  enable = cfg.enable && config.boot.loader.grub.enable;

  # TODO @getchoo: upstream this in nixpkgs maybe? idk if they have grub themes
  theme = pkgs.runCommand "catppuccin-grub-theme" { } ''
    mkdir -p "$out"
    cp -r ${sources.grub}/src/catppuccin-${cfg.flavor}-grub-theme/* "$out"/
  '';
in
{
  options.boot.loader.grub.catppuccin = catppuccinLib.mkCatppuccinOption { name = "grub"; };

  config.boot.loader.grub = lib.mkIf enable {
    font = "${theme}/font.pf2";
    splashImage = "${theme}/background.png";
    inherit theme;
  };
}

{
  config,
  lib,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.boot.loader.grub.catppuccin;
  enable = cfg.enable && config.boot.loader.grub.enable;

  # TODO @getchoo: upstream this in nixpkgs maybe? idk if they have grub themes
  theme = sources.grub + "/share/grub/themes/catppuccin-${cfg.flavor}-grub-theme";
in
{
  options.boot.loader.grub.catppuccin = lib.ctp.mkCatppuccinOpt { name = "grub"; };

  config.boot.loader.grub = lib.mkIf enable {
    font = "${theme}/font.pf2";
    splashImage = "${theme}/background.png";
    inherit theme;
  };
}

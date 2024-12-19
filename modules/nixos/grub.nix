{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.grub;

  # TODO @getchoo: upstream this in nixpkgs maybe? idk if they have grub themes
  theme = sources.grub + "/share/grub/themes/catppuccin-${cfg.flavor}-grub-theme";
in

{
  options.catppuccin.grub = catppuccinLib.mkCatppuccinOption { name = "grub"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "boot"
      "loader"
      "grub"
      "catppuccin"
    ];
    to = "grub";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      font = "${theme}/font.pf2";
      splashImage = "${theme}/background.png";
      inherit theme;
    };
  };
}

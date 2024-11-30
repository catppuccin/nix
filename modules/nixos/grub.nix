{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.grub;
  enable = cfg.enable && config.boot.loader.grub.enable;

  # TODO @getchoo: upstream this in nixpkgs maybe? idk if they have grub themes
  theme = pkgs.runCommand "catppuccin-grub-theme" { } ''
    mkdir -p "$out"
    cp -r ${sources.grub}/src/catppuccin-${cfg.flavor}-grub-theme/* "$out"/
  '';
in
{
  options.catppuccin.grub = lib.ctp.mkCatppuccinOpt { name = "grub"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "boot"
      "loader"
      "grub"
      "catppuccin"
    ];
    to = "grub";
  };

  config.boot.loader.grub = lib.mkIf enable {
    font = "${theme}/font.pf2";
    splashImage = "${theme}/background.png";
    inherit theme;
  };
}

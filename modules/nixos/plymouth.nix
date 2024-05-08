{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.boot.plymouth.catppuccin;
  enable = cfg.enable && config.boot.plymouth.enable;
in
{
  options.boot.plymouth.catppuccin = ctp.mkCatppuccinOpt "plymouth";

  config.boot.plymouth = mkIf enable {
    theme = "catppuccin-${cfg.flavour}";
    themePackages = [
      (pkgs.catppuccin-plymouth.override {
        variant = cfg.flavour;
      })
    ];
  };
}

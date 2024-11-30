{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.catppuccin.plymouth;
  enable = cfg.enable && config.boot.plymouth.enable;
in
{
  options.catppuccin.plymouth = ctp.mkCatppuccinOpt { name = "plymouth"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "boot"
      "plymouth"
      "catppuccin"
    ];
    to = "plymouth";
  };

  config.boot.plymouth = mkIf enable {
    theme = "catppuccin-${cfg.flavor}";
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = cfg.flavor; }) ];
  };
}

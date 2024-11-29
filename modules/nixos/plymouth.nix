{
  config,
  lib,
  ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.boot.plymouth.catppuccin;
  enable = cfg.enable && config.boot.plymouth.enable;
in
{
  options.boot.plymouth.catppuccin = ctp.mkCatppuccinOpt { name = "plymouth"; };

  config.boot.plymouth = mkIf enable {
    theme = "catppuccin-${cfg.flavor}";
    themePackages = [ config.catppuccin.sources.plymouth ];
  };
}

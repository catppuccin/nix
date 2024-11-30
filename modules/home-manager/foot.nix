{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.foot;
  enable = cfg.enable && config.programs.foot.enable;
in
{
  options.catppuccin.foot = lib.ctp.mkCatppuccinOpt { name = "foot"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "foot"
      "catppuccin"
    ];
    to = "foot";
  };

  config.programs.foot = lib.mkIf enable {
    settings.main.include = sources.foot + "/themes/catppuccin-${cfg.flavor}.ini";
  };
}

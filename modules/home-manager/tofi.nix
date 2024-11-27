{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.tofi.catppuccin;
  enable = cfg.enable && config.programs.tofi.enable;
in
{
  options.programs.tofi.catppuccin = lib.ctp.mkCatppuccinOption { name = "tofi"; };

  config.programs.tofi = lib.mkIf enable {
    settings.include = sources.tofi + "/themes/catppuccin-${cfg.flavor}";
  };
}

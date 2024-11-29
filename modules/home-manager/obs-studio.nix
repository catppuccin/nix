{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.obs-studio.catppuccin;
  enable = cfg.enable && config.programs.obs-studio.enable;

  themeName = "Catppuccin_${lib.ctp.mkUpper cfg.flavor}.ovt";
in
{
  options.programs.obs-studio.catppuccin = lib.ctp.mkCatppuccinOpt { name = "obs-studio"; };

  config = lib.mkIf enable {
    xdg.configFile."obs-studio/themes/Catppuccin.obt".source = "${sources.obs}/Catppuccin.obt";
    xdg.configFile."obs-studio/themes/${themeName}".source = "${sources.obs}/${themeName}";
  };
}

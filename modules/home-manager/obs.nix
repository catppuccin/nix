{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.obs;
  enable = config.catppuccin._enable && cfg.enable && config.programs.obs-studio.enable;

  themeName = "Catppuccin_${lib.toSentenceCase cfg.flavor}.ovt";
in

{
  options.catppuccin.obs = catppuccinLib.mkCatppuccinOption { name = "obs-studio"; };

  config = lib.mkIf enable {
    xdg.configFile = {
      "obs-studio/themes/Catppuccin.obt".source = "${sources.obs}/Catppuccin.obt";
      "obs-studio/themes/${themeName}".source = "${sources.obs}/${themeName}";
    };
  };
}

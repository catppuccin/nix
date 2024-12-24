{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.obs;
  enable = cfg.enable && config.programs.obs-studio.enable;

  themeName = "Catppuccin_${catppuccinLib.mkUpper cfg.flavor}.ovt";
in

{
  options.catppuccin.obs = catppuccinLib.mkCatppuccinOption { name = "obs-studio"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "obs-studio"
      "catppuccin"
    ];
    to = "obs";
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "obs-studio/themes/Catppuccin.obt".source = "${sources.obs}/Catppuccin.obt";
      "obs-studio/themes/${themeName}".source = "${sources.obs}/${themeName}";
    };
  };
}

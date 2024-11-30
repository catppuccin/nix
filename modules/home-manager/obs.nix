{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.obs;
  enable = cfg.enable && config.programs.obs-studio.enable;

  themeName = "Catppuccin_${lib.ctp.mkUpper cfg.flavor}.ovt";
in
{
  options.catppuccin.obs = lib.ctp.mkCatppuccinOpt { name = "obs"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "obs-studio"
      "catppuccin"
    ];
    to = "obs";
  };

  config = lib.mkIf enable {
    xdg.configFile."obs-studio/themes/Catppuccin.obt".source = "${sources.obs}/themes/Catppuccin.obt";
    xdg.configFile."obs-studio/themes/${themeName}".source = "${sources.obs}/themes/${themeName}";
  };
}

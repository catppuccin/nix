{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fish.catppuccin;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${lib.ctp.mkUpper cfg.flavor}";
  themePath = "/themes/${themeName}.theme";
in
{
  options.programs.fish.catppuccin = lib.ctp.mkCatppuccinOption { name = "fish"; };

  config = lib.mkIf enable {
    xdg.configFile."fish${themePath}".source = "${sources.fish}${themePath}";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

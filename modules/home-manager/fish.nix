{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fish.catppuccin;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${lib.ctp.mkUpper cfg.flavor}";
in
{
  options.programs.fish.catppuccin = lib.ctp.mkCatppuccinOpt { name = "fish"; };

  config = lib.mkIf enable {
    xdg.configFile."fish/themes/${themeName}.theme".source = "${sources.fish}/${themeName}.theme";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

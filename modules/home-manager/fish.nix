{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fish;
  enable = config.catppuccin._enable && cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${lib.toSentenceCase cfg.flavor}";
in

{
  options.catppuccin.fish = catppuccinLib.mkCatppuccinOption { name = "fish"; };

  config = lib.mkIf enable {
    xdg.configFile."fish/themes/${themeName}.theme".source = "${sources.fish}/${themeName}.theme";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

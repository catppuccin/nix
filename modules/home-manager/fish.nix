{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fish;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${catppuccinLib.mkUpper cfg.flavor}";
  themePath = "/themes/${themeName}.theme";
in

{
  options.catppuccin.fish = catppuccinLib.mkCatppuccinOption { name = "fish"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "fish"
      "catppuccin"
    ];
    to = "fish";
  };

  config = lib.mkIf enable {
    xdg.configFile."fish${themePath}".source = "${sources.fish}${themePath}";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

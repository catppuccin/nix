{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fish;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${catppuccinLib.mkUpper cfg.flavor}";
in

{
  options.catppuccin.fish = catppuccinLib.mkCatppuccinOption { name = "fish"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "fish"
      "catppuccin"
    ];
    to = "fish";
  };

  config = lib.mkIf enable {
    xdg.configFile."fish/themes/${themeName}.theme".source = "${sources.fish}/${themeName}.theme";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

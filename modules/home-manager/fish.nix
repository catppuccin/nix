{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.fish;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${lib.ctp.mkUpper cfg.flavor}";
  themePath = "/themes/${themeName}.theme";
in
{
  options.catppuccin.fish = lib.ctp.mkCatppuccinOpt { name = "fish"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
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

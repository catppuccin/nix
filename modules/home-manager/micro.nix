{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.micro;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "catppuccin-${cfg.flavor}.micro";
in

{
  options.catppuccin.micro = catppuccinLib.mkCatppuccinOption { name = "micro"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "micro"
      "catppuccin"
    ];
    to = "micro";
  };

  config = lib.mkIf enable {
    programs.micro = {
      settings = {
        colorscheme = lib.removeSuffix ".micro" themePath;
      };
    };

    xdg.configFile = {
      "micro/colorschemes/${themePath}".source = "${sources.micro}/src/${themePath}";
    };
  };
}

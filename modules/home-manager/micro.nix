{ config
, lib
, ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.micro.catppuccin;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "catppuccin-${cfg.flavour}.micro";
in
{
  options.programs.micro.catppuccin =
    lib.ctp.mkCatppuccinOpt "micro";

  config = lib.mkIf enable {
    assertions = [
      (lib.ctp.assertXdgEnabled "micro")
    ];

    programs.micro.settings.colorscheme = lib.removeSuffix ".micro" themePath;

    xdg.configFile."micro/colorschemes/${themePath}".source = "${sources.micro}/src/${themePath}";
  };
}

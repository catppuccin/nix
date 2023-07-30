{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.micro.catppuccin;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "catppuccin-${cfg.flavour}.micro";
in
{
  options.programs.micro.catppuccin =
    lib.ctp.mkCatppuccinOpt "micro" config;

  config = lib.mkIf enable {
    programs.micro.settings.colorscheme = lib.removeSuffix ".micro" themePath;

    xdg = {
      # xdg is required for this to work
      enable = lib.mkForce true;
      configFile."micro/colorschemes/${themePath}".source = "${sources.micro}/src/${themePath}";
    };
  };
}

{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.bat.catppuccin;
  enable = cfg.enable && config.programs.bat.enable;
  themeName = "Catppuccin-${cfg.flavour}";
in
{
  options.programs.bat.catppuccin =
    lib.ctp.mkCatppuccinOpt "bat";

  config = lib.mkIf enable {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = sources.bat;
        file = "${themeName}.tmTheme";
      };
    };
  };
}

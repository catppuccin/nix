{ config
, lib
, inputs
, ...
}:
let
  cfg = config.programs.bat.catppuccin;
  enable = cfg.enable && config.programs.bat.enable;
  themeName = "Catppuccin-${cfg.flavour}";
in
{
  options.programs.bat.catppuccin =
    lib.ctp.mkCatppuccinOpt "bat" config;

  config = lib.mkIf enable {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = inputs.bat;
        file = "${themeName}.tmTheme";
      };
    };
  };
}

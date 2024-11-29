{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.bat.catppuccin;
  enable = cfg.enable && config.programs.bat.enable;
  themeName = "Catppuccin ${lib.ctp.mkUpper cfg.flavor}";
in
{
  options.programs.bat.catppuccin = lib.ctp.mkCatppuccinOpt { name = "bat"; };

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

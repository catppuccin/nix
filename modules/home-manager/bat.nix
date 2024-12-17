{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.bat.catppuccin;
  themeName = "Catppuccin ${catppuccinLib.mkUpper cfg.flavor}";
in

{
  options.programs.bat.catppuccin = catppuccinLib.mkCatppuccinOption { name = "bat"; };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = sources.bat;
        file = "themes/${themeName}.tmTheme";
      };
    };
  };
}

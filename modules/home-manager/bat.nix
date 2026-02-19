{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.bat;
  themeName = "Catppuccin ${lib.toSentenceCase cfg.flavor}";
in

{
  options.catppuccin.bat = catppuccinLib.mkCatppuccinOption { name = "bat"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = sources.bat;
        file = "${themeName}.tmTheme";
      };
    };
  };
}

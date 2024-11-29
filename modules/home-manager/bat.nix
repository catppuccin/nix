{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.bat;
  themeName = "Catppuccin ${catppuccinLib.mkUpper cfg.flavor}";
in

{
  options.catppuccin.bat = catppuccinLib.mkCatppuccinOption { name = "bat"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "bat"
      "catppuccin"
    ];
    to = "bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = sources.bat;
        file = "${themeName}.tmTheme";
      };
    };
  };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.bat;
  enable = cfg.enable && config.programs.bat.enable;
  themeName = "Catppuccin ${lib.ctp.mkUpper cfg.flavor}";
in
{
  options.catppuccin.bat = lib.ctp.mkCatppuccinOpt { name = "bat"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "bat"
      "catppuccin"
    ];
    to = "bat";
  };

  config = lib.mkIf enable {
    programs.bat = {
      config.theme = themeName;

      themes.${themeName} = {
        src = sources.bat;
        file = "themes/${themeName}.tmTheme";
      };
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.television;
  enable = config.programs.television.enable && cfg.enable;
in

{
  options.catppuccin.television = catppuccinLib.mkCatppuccinOption {
    name = "television";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.television = {
      settings = {
        ui.theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
      };
    };

    xdg.configFile = {
      "television/themes/catppuccin-${cfg.flavor}-${cfg.accent}.toml".source =
        sources.television + "/catppuccin-${cfg.flavor}-${cfg.accent}.toml";
    };
  };
}

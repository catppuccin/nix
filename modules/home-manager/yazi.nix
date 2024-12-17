{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in

{
  options.programs.yazi.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "yazi";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.yazi = {
      theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";
    };

    xdg.configFile = {
      "yazi/Catppuccin-${cfg.flavor}.tmTheme".source =
        "${sources.bat}/themes/Catppuccin ${catppuccinLib.mkUpper cfg.flavor}.tmTheme";
    };
  };
}

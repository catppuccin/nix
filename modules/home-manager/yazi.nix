{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.yazi;
  enable = cfg.enable && config.programs.yazi.enable;
in

{
  options.catppuccin.yazi = catppuccinLib.mkCatppuccinOption {
    name = "yazi";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "yazi"
      "catppuccin"
    ];
    to = "yazi";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.yazi = {
      theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";
    };

    xdg.configFile = {
      "yazi/Catppuccin-${cfg.flavor}.tmTheme".source = "${sources.bat}/themes/Catppuccin ${catppuccinLib.mkUpper cfg.flavor}.tmTheme";
    };
  };
}

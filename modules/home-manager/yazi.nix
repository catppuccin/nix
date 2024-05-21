{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.programs.yazi.catppuccin = lib.ctp.mkCatppuccinOpt "yazi";

  config = lib.mkIf enable {
    programs.yazi.theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavour}.toml";
    xdg.configFile."yazi/Catppuccin-${cfg.flavour}.tmTheme".source = "${sources.bat}/themes/Catppuccin ${lib.ctp.mkUpper cfg.flavour}.tmTheme";
  };
}

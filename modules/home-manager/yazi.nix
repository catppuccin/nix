{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.programs.yazi.catppuccin = lib.ctp.mkCatppuccinOpt { name = "yazi"; } // {
    accent = lib.ctp.mkAccentOpt "yazi";
  };

  config = lib.mkIf enable {
    programs.yazi.theme = lib.importTOML "${sources.yazi}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";
    xdg.configFile."yazi/Catppuccin-${cfg.flavor}.tmTheme".source = "${sources.bat}/Catppuccin ${lib.ctp.mkUpper cfg.flavor}.tmTheme";
  };
}

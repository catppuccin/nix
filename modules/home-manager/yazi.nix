{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.yazi;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.catppuccin.yazi = lib.ctp.mkCatppuccinOpt { name = "yazi"; } // {
    accent = lib.ctp.mkAccentOpt "yazi";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "yazi"
      "catppuccin"
    ];
    to = "yazi";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.yazi.theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";
    xdg.configFile."yazi/Catppuccin-${cfg.flavor}.tmTheme".source = "${sources.bat}/themes/Catppuccin ${lib.ctp.mkUpper cfg.flavor}.tmTheme";
  };
}

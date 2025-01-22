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
    xdg.configFile = {
      "yazi/theme.toml".source =
        "${sources.yazi}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";

      "yazi/Catppuccin-${cfg.flavor}.tmTheme".source =
        "${sources.bat}/Catppuccin ${catppuccinLib.mkUpper cfg.flavor}.tmTheme";
    };
  };
}

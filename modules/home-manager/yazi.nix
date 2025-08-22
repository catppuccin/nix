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
    programs.yazi.theme = {
      flavor = {
        light = "catppuccin";
        dark = "catppuccin";
      };
    };

    xdg.configFile = {
      "yazi/flavors/catppuccin.yazi/flavor.toml".source =
        "${sources.yazi}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.toml";

      "yazi/flavors/catppuccin.yazi/tmTheme.tmtheme".source =
        "${sources.bat}/Catppuccin ${lib.toSentenceCase cfg.flavor}.tmTheme";
    };
  };
}

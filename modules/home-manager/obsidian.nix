{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.obsidian;
  enable = cfg.enable && config.programs.obsidian.enable;
in

{
  options.catppuccin.obsidian = catppuccinLib.mkCatppuccinOption { name = "obsidian"; };

  config = lib.mkIf enable {
    programs.obsidian.defaultSettings.themes = [
      {
        enable = true;
        pkg = sources.obsidian;
      }
    ];
  };
}

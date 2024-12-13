{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.alacritty.catppuccin;
in

{
  options.programs.alacritty.catppuccin = catppuccinLib.mkCatppuccinOption { name = "alacritty"; };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      settings = lib.importTOML "${sources.alacritty}/catppuccin-${cfg.flavor}.toml";
    };
  };
}

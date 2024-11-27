{ catppuccinLib }: 
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.alacritty.catppuccin;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.programs.alacritty.catppuccin = catppuccinLib.mkCatppuccinOption { name = "alacritty"; };

  config = lib.mkIf enable {
    programs.alacritty.settings = lib.importTOML "${sources.alacritty}/catppuccin-${cfg.flavor}.toml";
  };
}

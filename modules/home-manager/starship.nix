{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.starship.catppuccin;
in

{
  options.programs.starship.catppuccin = catppuccinLib.mkCatppuccinOption { name = "starship"; };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      settings = {
        format = lib.mkDefault "$all";
        palette = "catppuccin_${cfg.flavor}";
      } // lib.importTOML "${sources.starship}/themes/${cfg.flavor}.toml";
    };
  };
}

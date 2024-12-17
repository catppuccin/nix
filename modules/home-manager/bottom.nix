{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.bottom.catppuccin;
in

{
  options.programs.bottom.catppuccin = catppuccinLib.mkCatppuccinOption { name = "bottom"; };

  config = lib.mkIf cfg.enable {
    programs.bottom = {
      settings = lib.importTOML "${sources.bottom}/themes/${cfg.flavor}.toml";
    };
  };
}

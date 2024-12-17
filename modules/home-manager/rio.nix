{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.rio.catppuccin;
in

{
  options.programs.rio.catppuccin = catppuccinLib.mkCatppuccinOption { name = "rio"; };

  config = lib.mkIf cfg.enable {
    programs.rio = {
      settings = lib.importTOML "${sources.rio}/themes/catppuccin-${cfg.flavor}.toml";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rio;
in

{
  options.catppuccin.rio = catppuccinLib.mkCatppuccinOption { name = "rio"; };

  config = lib.mkIf cfg.enable {
    programs.rio = {
      settings = lib.importTOML "${sources.rio}/catppuccin-${cfg.flavor}.toml";
    };
  };
}

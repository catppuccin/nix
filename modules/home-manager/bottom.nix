{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.bottom;
in

{
  options.catppuccin.bottom = catppuccinLib.mkCatppuccinOption { name = "bottom"; };

  config = lib.mkIf cfg.enable {
    programs.bottom = {
      settings = lib.importTOML "${sources.bottom}/${cfg.flavor}.toml";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.spotify-player;
in

{
  options.catppuccin.spotify-player = catppuccinLib.mkCatppuccinOption {
    name = "spotify-player";
  };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.spotify-player = {
      settings.theme = "Catppuccin-${cfg.flavor}";
      inherit (lib.importTOML "${sources.spotify-player}/theme.toml") themes;
    };
  };
}

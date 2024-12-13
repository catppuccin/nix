{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.spotify-player.catppuccin;
in

{
  options.programs.spotify-player.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "spotify-player";
  };

  config = lib.mkIf cfg.enable {
    programs.spotify-player = {
      settings.theme = "Catppuccin-${cfg.flavor}";
      inherit (lib.importTOML "${sources.spotify-player}/theme.toml") themes;
    };
  };
}

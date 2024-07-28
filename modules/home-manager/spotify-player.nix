{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.spotify-player.catppuccin;
  enable = cfg.enable && config.programs.spotify-player.enable;
in
{
  options.programs.spotify-player.catppuccin = lib.ctp.mkCatppuccinOpt { name = "spotify-player"; };

  config = lib.mkIf enable {
    programs.spotify-player = {
      settings.theme = "Catppuccin-${cfg.flavor}";
      themes = (lib.importTOML "${sources.spotify-player}/theme.toml").themes;
    };
  };
}

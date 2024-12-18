{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.spotify-player;
  enable = cfg.enable && config.programs.spotify-player.enable;
in
{
  options.catppuccin.spotify-player = catppuccinLib.mkCatppuccinOption {
    name = "spotify-player";
  };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "spotify-player"
      "catppuccin"
    ];
    to = "spotify-player";
  };

  config = lib.mkIf cfg.enable {
    programs.spotify-player = {
      settings.theme = "Catppuccin-${cfg.flavor}";
      inherit (lib.importTOML "${sources.spotify-player}/theme.toml") themes;
    };
  };
}

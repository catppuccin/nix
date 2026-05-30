{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gemini-cli;
  enable = config.programs.gemini-cli.enable && cfg.enable;
in

{
  options.catppuccin.gemini-cli = catppuccinLib.mkCatppuccinOption { name = "gemini-cli"; };

  config = lib.mkIf enable {
    programs.gemini-cli = {
      settings.ui = {
        theme = "~/.gemini/catppuccin.json";
      };
    };

    home.file = {
      ".gemini/catppuccin.json".source = "${sources.gemini-cli}/catppuccin-${cfg.flavor}.json";
    };
  };
}

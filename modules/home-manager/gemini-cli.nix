{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gemini-cli;
  theme = lib.importJSON "${sources.gemini-cli}/catppuccin-${cfg.flavor}.json";
in

{
  options.catppuccin.gemini-cli = catppuccinLib.mkCatppuccinOption { name = "gemini-cli"; };

  config = lib.mkIf cfg.enable {
    programs.gemini-cli = {
      settings.ui = {
        theme = theme.name;
        customThemes.${theme.name} = theme;
      };
    };
  };
}

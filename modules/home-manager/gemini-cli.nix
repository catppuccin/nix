{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gemini-cli;
in

{
  options.catppuccin.gemini-cli = catppuccinLib.mkCatppuccinOption { name = "gemini-cli"; };

  config = lib.mkIf cfg.enable {
    programs.gemini-cli = {
      settings.ui = {
        theme = "${sources.gemini-cli}/catppuccin-${cfg.flavor}.json";
      };
    };
  };
}

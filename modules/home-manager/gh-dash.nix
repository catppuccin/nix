{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.gh-dash.catppuccin;
  theme = "${sources.gh-dash}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in

{
  options.programs.gh-dash.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "gh-dash";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.gh-dash = {
      settings = catppuccinLib.fromYaml theme;
    };
  };
}

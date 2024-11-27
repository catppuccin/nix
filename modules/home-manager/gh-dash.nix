{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.gh-dash.catppuccin;
  enable = cfg.enable && config.programs.gh-dash.enable;
  theme = "${sources.gh-dash}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in
{
  options.programs.gh-dash.catppuccin = lib.ctp.mkCatppuccinOption {
    name = "gh-dash";
    accentSupport = true;
  };

  config.programs.gh-dash.settings = lib.mkIf enable (lib.ctp.fromYaml theme);
}

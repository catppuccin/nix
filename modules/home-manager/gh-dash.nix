{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.gh-dash.catppuccin;
  enable = cfg.enable && config.programs.gh-dash.enable;
  theme = "${sources.gh-dash}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in
{
  options.programs.gh-dash.catppuccin = lib.ctp.mkCatppuccinOpt { name = "gh-dash"; } // {
    accent = lib.ctp.mkAccentOpt "gh-dash";
  };

  config.programs.gh-dash.settings = lib.mkIf enable (lib.ctp.fromYaml theme);
}

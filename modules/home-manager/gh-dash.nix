{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.gh-dash;
  enable = cfg.enable && config.programs.gh-dash.enable;
  theme = "${sources.gh-dash}/themes/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in
{
  options.catppuccin.gh-dash = lib.ctp.mkCatppuccinOpt { name = "gh-dash"; } // {
    accent = lib.ctp.mkAccentOpt "gh-dash";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "gh-dash"
      "catppuccin"
    ];
    to = "gh-dash";
    accentSupport = true;
  };

  config.programs.gh-dash.settings = lib.mkIf enable (lib.ctp.fromYaml theme);
}

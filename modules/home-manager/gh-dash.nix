{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.gh-dash;
  theme = "${sources.gh-dash}/${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.yml";
in

{
  options.catppuccin.gh-dash = catppuccinLib.mkCatppuccinOption {
    name = "gh-dash";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "gh-dash"
      "catppuccin"
    ];
    to = "gh-dash";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.gh-dash = {
      settings = catppuccinLib.importYAML theme;
    };
  };
}

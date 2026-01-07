{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.newsboat;
  theme = if cfg.flavor == "latte" then "latte" else "dark";
in

{
  options.catppuccin.newsboat = catppuccinLib.mkCatppuccinOption { name = "newsboat"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.newsboat = {
      extraConfig = lib.fileContents "${sources.newsboat}/${theme}";
    };
  };
}

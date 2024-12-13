{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.newsboat.catppuccin;
  theme = if cfg.flavor == "latte" then "latte" else "dark";
in

{
  options.programs.newsboat.catppuccin = catppuccinLib.mkCatppuccinOption { name = "newsboat"; };

  config = lib.mkIf cfg.enable {
    programs.newsboat = {
      extraConfig = lib.fileContents "${sources.newsboat}/themes/${theme}";
    };
  };
}

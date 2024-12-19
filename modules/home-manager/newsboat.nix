{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.newsboat;
  theme = if cfg.flavor == "latte" then "latte" else "dark";
in

{
  options.catppuccin.newsboat = catppuccinLib.mkCatppuccinOption { name = "newsboat"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "newsboat"
      "catppuccin"
    ];
    to = "newsboat";
  };

  config = lib.mkIf cfg.enable {
    programs.newsboat = {
      extraConfig = lib.fileContents "${sources.newsboat}/${theme}";
    };
  };
}

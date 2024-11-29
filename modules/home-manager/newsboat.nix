{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.newsboat.catppuccin;
  enable = cfg.enable && config.programs.newsboat.enable;
  theme = if cfg.flavor == "latte" then "latte" else "dark";
in
{
  options.programs.newsboat.catppuccin = lib.ctp.mkCatppuccinOpt { name = "newsboat"; };

  config = lib.mkIf enable {
    programs.newsboat.extraConfig = builtins.readFile "${sources.newsboat}/${theme}";
  };
}

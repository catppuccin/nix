{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.newsboat;
  enable = cfg.enable && config.programs.newsboat.enable;
  theme = if cfg.flavor == "latte" then "latte" else "dark";
in
{
  options.catppuccin.newsboat = lib.ctp.mkCatppuccinOpt { name = "newsboat"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "newsboat"
      "catppuccin"
    ];
    to = "newsboat";
  };

  config = lib.mkIf enable {
    programs.newsboat.extraConfig = builtins.readFile "${sources.newsboat}/themes/${theme}";
  };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.git.delta.catppuccin;
  enable = cfg.enable && config.programs.git.delta.enable;
in
{
  options.programs.git.delta.catppuccin = lib.ctp.mkCatppuccinOption { name = "delta"; };

  config = lib.mkIf enable {
    programs.git = {
      includes = [ { path = "${sources.delta}/catppuccin.gitconfig"; } ];
      delta.options.features = "catppuccin-${cfg.flavor}";
    };
  };
}

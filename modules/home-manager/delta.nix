{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.git.delta.catppuccin;
  enable = cfg.enable && config.programs.git.delta.enable;
in
{
  options.programs.git.delta.catppuccin =
    lib.ctp.mkCatppuccinOpt "catppuccin";

  config = lib.mkIf enable {
    programs.git = {
      includes = [
        {
          path = "${sources.delta}/catppuccin.gitconfig";
        }
      ];
      delta.options.features = "catppuccin-${cfg.flavour}";
    };
  };
}

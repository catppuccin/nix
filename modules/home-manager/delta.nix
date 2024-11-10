{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.delta;
  enable = cfg.enable && config.programs.git.delta.enable;
in
{
  options.catppuccin.delta = lib.ctp.mkCatppuccinOpt { name = "delta"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "git"
      "delta"
      "catppuccin"
    ];
    to = "delta";
  };

  config = lib.mkIf enable {
    programs.git = {
      includes = [ { path = "${sources.delta}/catppuccin.gitconfig"; } ];
      delta.options.features = "catppuccin-${cfg.flavor}";
    };
  };
}

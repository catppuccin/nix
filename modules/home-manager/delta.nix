{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.delta;
  enable = cfg.enable && config.programs.delta.enable;
in

{
  options.catppuccin.delta = catppuccinLib.mkCatppuccinOption { name = "delta"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "git"
      "delta"
      "catppuccin"
    ];
    to = "delta";
  };

  config = lib.mkIf enable {
    programs.delta.options.features = "catppuccin-${cfg.flavor}";
    programs.git = lib.mkIf config.programs.delta.enableGitIntegration {
      includes = [ { path = "${sources.delta}/catppuccin.gitconfig"; } ];
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.halloy;
  enable = cfg.enable && config.programs.halloy.enable;
in

{
  options.catppuccin.halloy = catppuccinLib.mkCatppuccinOption { name = "halloy"; };

  config = lib.mkIf enable {
    programs.halloy = {
      settings = {
        theme = "catppuccin-${cfg.flavor}";
      };
    };

    xdg.configFile = {
      "halloy/themes/catppuccin-${cfg.flavor}.toml".source =
        sources.halloy + "/catppuccin-${cfg.flavor}.toml";
    };
  };
}

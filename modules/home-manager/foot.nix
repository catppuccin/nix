{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.foot;
in

{
  options.catppuccin.foot = catppuccinLib.mkCatppuccinOption { name = "foot"; };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.foot = {
      settings = {
        main.include = sources.foot + "/static/catppuccin-${cfg.flavor}.ini";
      };
    };
  };
}

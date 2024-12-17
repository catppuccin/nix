{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.foot.catppuccin;
in

{
  options.programs.foot.catppuccin = catppuccinLib.mkCatppuccinOption { name = "foot"; };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      settings = {
        main.include = sources.foot + "/themes/catppuccin-${cfg.flavor}.ini";
      };
    };
  };
}

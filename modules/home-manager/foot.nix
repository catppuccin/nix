{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.foot;
in

{
  options.catppuccin.foot = catppuccinLib.mkCatppuccinOption { name = "foot"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "foot"
      "catppuccin"
    ];
    to = "foot";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      settings = {
        main.include = sources.foot + "/catppuccin-${cfg.flavor}.ini";
      };
    };
  };
}

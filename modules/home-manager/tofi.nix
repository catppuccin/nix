{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.tofi;
in

{
  options.catppuccin.tofi = catppuccinLib.mkCatppuccinOption { name = "tofi"; };

  config = lib.mkIf cfg.enable {
    programs.tofi = {
      settings = {
        include = sources.tofi + "/catppuccin-${cfg.flavor}";
      };
    };
  };
}

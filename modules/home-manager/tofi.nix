{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.tofi.catppuccin;
in

{
  options.programs.tofi.catppuccin = catppuccinLib.mkCatppuccinOption { name = "tofi"; };

  config = lib.mkIf cfg.enable {
    programs.tofi = {
      settings = {
        include = sources.tofi + "/themes/catppuccin-${cfg.flavor}";
      };
    };
  };
}

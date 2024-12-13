{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.programs.zellij.catppuccin;
  themeName = "catppuccin-${cfg.flavor}";
in

{
  options.programs.zellij.catppuccin = catppuccinLib.mkCatppuccinOption { name = "zellij"; };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      settings = {

        theme = themeName;
      };
    };
  };
}

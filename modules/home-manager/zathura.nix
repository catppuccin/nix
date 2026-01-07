{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zathura;
in

{
  options.catppuccin.zathura = catppuccinLib.mkCatppuccinOption { name = "zathura"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.zathura = {
      extraConfig = ''
        include ${sources.zathura + "/catppuccin-${cfg.flavor}"}
      '';
    };
  };
}

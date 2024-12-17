{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.zathura.catppuccin;
in

{
  options.programs.zathura.catppuccin = catppuccinLib.mkCatppuccinOption { name = "zathura"; };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      extraConfig = ''
        include ${sources.zathura + "/src/catppuccin-${cfg.flavor}"}
      '';
    };
  };
}

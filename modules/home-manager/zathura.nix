{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zathura;
in
{
  options.catppuccin.zathura = catppuccinLib.mkCatppuccinOption { name = "zathura"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "zathura"
      "catppuccin"
    ];
    to = "zathura";
  };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      extraConfig = ''
        include ${sources.zathura + "/src/catppuccin-${cfg.flavor}"}
      '';
    };
  };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.aerc.catppuccin;
  enable = cfg.enable && config.programs.aerc.enable;
  themeName = "catppuccin-${cfg.flavor}";
in
{
  options.programs.aerc.catppuccin = lib.ctp.mkCatppuccinOpt { name = "aerc"; };

  config = lib.mkIf enable {
    programs.aerc = {
      stylesets.${themeName} = builtins.readFile "${sources.aerc}/${themeName}";
      extraConfig = {
        ui = {
          styleset-name = themeName;
          border-char-vertical = "│";
          border-char-horizontal = "─";
        };
      };
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.aerc;
  themeName = "catppuccin-${cfg.flavor}";
in

{
  options.catppuccin.aerc = catppuccinLib.mkCatppuccinOption { name = "aerc"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.aerc = {
      stylesets.${themeName} = lib.fileContents "${sources.aerc}/${themeName}";
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

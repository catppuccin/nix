{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.aerc.catppuccin;
  themeName = "catppuccin-${cfg.flavor}";
in

{
  options.programs.aerc.catppuccin = catppuccinLib.mkCatppuccinOption { name = "aerc"; };

  config = lib.mkIf cfg.enable {
    programs.aerc = {
      stylesets.${themeName} = lib.fileContents "${sources.aerc}/dist/${themeName}";
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

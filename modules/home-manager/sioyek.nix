{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  
  cfg = config.catppuccin.sioyek;
  enable = cfg.enable && config.programs.sioyek.enable;
  
  themeFile = "/catppuccin-${cfg.flavor}.config";
  theme = sources.sioyek + themeFile;
in
 
{
  options.catppuccin.sioyek = catppuccinLib.mkCatppuccinOption {
    name = "sioyek";
  };

  config = lib.mkIf enable {
    programs.sioyek.config = catppuccinLib.importINI theme;
  };
} 
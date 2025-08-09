{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.sioyek;
  enable = cfg.enable && config.programs.sioyek.enable;
in

{
  options.catppuccin.sioyek = catppuccinLib.mkCatppuccinOption {
    name = "sioyek";
  };

  config = lib.mkIf enable {
    programs.sioyek.config.source = sources.sioyek + "/catppuccin-${cfg.flavor}.config";
  };
}

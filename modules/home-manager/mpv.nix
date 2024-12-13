{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.mpv.catppuccin;
in

{
  options.programs.mpv.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "mpv";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      config = {
        include = sources.mpv + "/themes/${cfg.flavor}/${cfg.accent}.conf";
      };
    };
  };
}

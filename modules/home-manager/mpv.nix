{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.mpv;
in

{
  options.catppuccin.mpv = catppuccinLib.mkCatppuccinOption {
    name = "mpv";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "mpv"
      "catppuccin"
    ];
    to = "mpv";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      config = {
        include = sources.mpv + "/${cfg.flavor}/${cfg.accent}.conf";
      };
    };
  };
}

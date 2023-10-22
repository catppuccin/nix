{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.wayland.windowManager.sway.catppuccin;
  enable = cfg.enable && config.wayland.windowManager.sway.enable;
  theme =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "sway";
        rev = "c89098fc3517b64f0422aaaccb98dcab6ae9348f";
        sha256 = "sha256-6Cvsmdl3OILz1vZovyBIuuSpm207I3W0dmUGowR9Ugk=";
      }
    + "/themes/catppuccin-${cfg.flavour}";
in
{
  options.wayland.windowManager.sway.catppuccin =
    lib.ctp.mkCatppuccinOpt "sway" config;

  config.wayland.windowManager.sway.extraConfigEarly =
    lib.mkIf enable ''
      include ${theme}
    '';
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.sway;
  theme = "${sources.sway}/themes/catppuccin-${cfg.flavor}";
in
{
  options.catppuccin.sway = catppuccinLib.mkCatppuccinOption { name = "sway"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "wayland"
      "windowManager"
      "sway"
      "catppuccin"
    ];
    to = "sway";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      extraConfigEarly = ''
        include ${theme}
      '';
    };
  };
}

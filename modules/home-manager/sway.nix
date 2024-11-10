{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.sway;
  enable = cfg.enable && config.wayland.windowManager.sway.enable;
  theme = "${sources.sway}/themes/catppuccin-${cfg.flavor}";
in
{
  options.catppuccin.sway = lib.ctp.mkCatppuccinOpt { name = "sway"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "wayland"
      "windowManager"
      "sway"
      "catppuccin"
    ];
    to = "sway";
  };

  config = lib.mkIf enable {
    wayland.windowManager.sway.extraConfigEarly = ''
      include ${theme}
    '';
  };
}

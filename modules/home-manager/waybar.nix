{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.waybar.catppuccin;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  options.programs.waybar.catppuccin = lib.ctp.mkCatppuccinOpt "waybar";

  config.programs.waybar = lib.mkIf enable {
    style = lib.mkBefore ''
      @import "${sources.waybar}/themes/${cfg.flavour}.css";
    '';
  };
}

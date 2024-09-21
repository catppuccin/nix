{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.hyprlock.catppuccin;
  enable = cfg.enable && config.programs.hyprlock.enable;
in
{
  options.programs.hyprlock.catppuccin = lib.ctp.mkCatppuccinOpt { name = "hyprlock"; } // {
    accent = lib.ctp.mkAccentOpt "hyprlock";
  };

  config = lib.mkIf enable {
    programs.hyprlock.settings = {
      source = [ "${sources.hyprland}/themes/${cfg.flavor}.conf" ];
      "$accent" = "\$${cfg.accent}";
      "$accentAlpha" = "\$${cfg.accent}Alpha";
    };
  };
}

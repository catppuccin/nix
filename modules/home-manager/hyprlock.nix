{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.hyprlock.catppuccin;
  enable = cfg.enable && config.programs.hyprlock.enable;
in
{
  options.programs.hyprlock.catppuccin = lib.ctp.mkCatppuccinOption {
    name = "hyprlock";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    programs.hyprlock.settings = {
      source = [
        "${sources.hyprland}/themes/${cfg.flavor}.conf"
        # Define accents in file to ensure they appear before user vars
        (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
          $accent = ''$${cfg.accent}
          $accentAlpha = ''$${cfg.accent}Alpha
        '')
      ];
    };
  };
}

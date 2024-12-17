{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.hyprlock.catppuccin;
in

{
  options.programs.hyprlock.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "hyprlock";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      settings = {
        source = [
          "${sources.hyprland}/themes/${cfg.flavor}.conf"

          # Define accents in file to ensure they appear before user vars
          (pkgs.writeText "hyprland-${cfg.accent}-accent.conf" ''
            $accent = ''$${cfg.accent}
            $accentAlpha = ''$${cfg.accent}Alpha
          '')
        ];
      };
    };
  };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.hyprlock;
  enable = cfg.enable && config.programs.hyprlock.enable;
in
{
  options.catppuccin.hyprlock = lib.ctp.mkCatppuccinOpt { name = "hyprlock"; } // {
    accent = lib.ctp.mkAccentOpt "hyprlock";
  };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "hyprlock"
      "catppuccin"
    ];
    to = "hyprlock";
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

{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.hyprlock;
in

{
  options.catppuccin.hyprlock =
    catppuccinLib.mkCatppuccinOption {
      name = "hyprlock";
      accentSupport = true;
    }
    // {
      useDefaultConfig = lib.mkEnableOption "the default configuration of the port" // {
        default = true;
      };

      font = lib.mkOption {
        type = lib.types.str;
        default =
          if config.catppuccin.font != null then config.catppuccin.font else "JetBrainsMono Nerd Font";
        defaultText = ''if catppuccin.font != null then catppuccin.font else "JetBrainsMono Nerd Font"'';
        description = "Font to use for hyprlock";
      };
    };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.hyprlock = {
      settings = {
        source = [
          "${sources.hyprlock}/${cfg.flavor}.conf"

          # Define accents and font in file to ensure they appear before user vars
          (pkgs.writeText "hyprland-${cfg.accent}-accent.conf" ''
            $accent = ''$${cfg.accent}
            $accentAlpha = ''$${cfg.accent}Alpha
            $font = ${cfg.font}
          '')
        ]
        ++ lib.optional cfg.useDefaultConfig "${sources.hyprlock}/hyprlock.conf";
      };
    };
  };
}

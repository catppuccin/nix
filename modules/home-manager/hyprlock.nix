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
    };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "hyprlock"
      "catppuccin"
    ];
    to = "hyprlock";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      settings = {
        source = [
          "${sources.hyprland}/${cfg.flavor}.conf"

          # Define accents in file to ensure they appear before user vars
          (pkgs.writeText "hyprland-${cfg.accent}-accent.conf" ''
            $accent = ''$${cfg.accent}
            $accentAlpha = ''$${cfg.accent}Alpha
          '')
        ] ++ lib.optional cfg.useDefaultConfig sources.hyprlock;
      };
    };
  };
}

{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.swaync;

  enable = cfg.enable && config.services.swaync.enable;

  theme = pkgs.substitute {
    src = sources.swaync + "/${cfg.flavor}.css";

    substitutions = [
      "--replace-warn"
      "Ubuntu Nerd Font"
      cfg.font
    ];
  };
in

{
  options.catppuccin.swaync =
    catppuccinLib.mkCatppuccinOption {
      name = "swaync";
    }
    // {
      font = lib.mkOption {
        type = lib.types.str;
        default = "Ubuntu Nerd Font";
        description = "Font to use for the notification center";
      };
    };

  config = lib.mkIf enable {
    services.swaync.style = theme;

    # Install the default font if it is selected
    home.packages = lib.mkIf (cfg.font == "Ubuntu Nerd Font") [
      # TODO: Remove when 25.05 is stable and `nerdfonts` is fully deprecated
      (
        if pkgs ? "nerd-fonts" then
          pkgs.nerd-fonts.ubuntu
        else
          pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; }
      )
    ];
  };
}

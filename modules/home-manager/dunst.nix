{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.dunst;
  enable = config.catppuccin.enable && cfg.enable && config.services.dunst.enable;
in

{
  options.catppuccin.dunst =
    catppuccinLib.mkCatppuccinOption {
      name = "dunst";
      fontSupport = true;
    }
    // {
      prefix = lib.mkOption {
        type = lib.types.str;
        default = "00";
        description = "Prefix to use for the dunst drop-in file";
      };
    };

  # Dunst currently has no "include" functionality, but has "drop-ins"
  # Unfortunately, this may cause inconvenience as it overrides ~/.config/dunst/dunstrc
  # but it can be overridden by another drop-in.
  config = lib.mkIf enable {
    services.dunst.settings.global = lib.mkIf (cfg.font != null) {
      font = lib.mkDefault "${cfg.font}${
        lib.optionalString (cfg.fontSize != null) " ${toString cfg.fontSize}"
      }";
    };

    xdg.configFile = {
      # Using a prefix like this is necessary because drop-ins' precedence depends on lexical order
      # such that later drop-ins override earlier ones
      # This way, users have better control over precedence
      "dunst/dunstrc.d/${cfg.prefix}-catppuccin.conf".source = sources.dunst + "/${cfg.flavor}.conf";
    };
  };
}

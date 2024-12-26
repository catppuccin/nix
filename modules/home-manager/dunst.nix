{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.dunst;
  enable = cfg.enable && config.services.dunst.enable;
in

{
  options.catppuccin.dunst = catppuccinLib.mkCatppuccinOption { name = "dunst"; } // {
    prefix = lib.mkOption {
      type = lib.types.str;
      default = "00";
      description = "Prefix to use for the dunst drop-in file";
    };
  };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "services"
        "dunst"
        "catppuccin"
      ];
      to = "dunst";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "services"
          "dunst"
          "catppuccin"
          "prefix"
        ]
        [
          "catppuccin"
          "dunst"
          "prefix"
        ]
      )
    ];

  # Dunst currently has no "include" functionality, but has "drop-ins"
  # Unfortunately, this may cause inconvenience as it overrides ~/.config/dunst/dunstrc
  # but it can be overridden by another drop-in.
  config = lib.mkIf enable {
    xdg.configFile = {
      # Using a prefix like this is necessary because drop-ins' precedence depends on lexical order
      # such that later drop-ins override earlier ones
      # This way, users have better control over precedence
      "dunst/dunstrc.d/${cfg.prefix}-catppuccin.conf".source = sources.dunst + "/${cfg.flavor}.conf";
    };
  };
}

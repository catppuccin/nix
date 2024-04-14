{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) ctp mkOption types;
  cfg = config.gtk.catppuccin;
  enable = cfg.enable && config.gtk.enable;
  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = ctp.mergeEnums (ctp.types.accentOption) (lib.types.enum [ "dark" "light" ]);
in
{
  options.gtk.catppuccin =
    ctp.mkCatppuccinOpt "gtk"
    // {
      accent = ctp.mkAccentOpt "gtk";
      size = mkOption {
        type = types.enum [ "standard" "compact" ];
        default = "standard";
        description = "Catppuccin size variant for gtk";
      };
      tweaks = mkOption {
        type = types.listOf (types.enum [ "black" "rimless" "normal" ]);
        default = [ "normal" ];
        description = "Catppuccin tweaks for gtk";
      };

      cursor = ctp.mkCatppuccinOpt "gtk cursors"
      // {
        accent = ctp.mkBasicOpt "accent" cursorAccentType "gtk cursors";
      };
    };

  config.gtk = lib.mkIf enable {
    theme =
      let
        flavourUpper = ctp.mkUpper cfg.flavour;
        accentUpper = ctp.mkUpper cfg.accent;
        sizeUpper = ctp.mkUpper cfg.size;

        # use the light gtk theme for latte
        gtkTheme =
          if cfg.flavour == "latte"
          then "Light"
          else "Dark";
      in
      {
        name = "Catppuccin-${flavourUpper}-${sizeUpper}-${accentUpper}-${gtkTheme}";
        package = pkgs.catppuccin-gtk.override {
          inherit (cfg) size tweaks;
          accents = [ cfg.accent ];
          variant = cfg.flavour;
        };
      };

    cursorTheme =
      let
        flavourUpper = ctp.mkUpper cfg.cursor.flavour;
        accentUpper = ctp.mkUpper cfg.cursor.accent;
      in
      lib.mkIf cfg.cursor.enable {
        name = "Catppuccin-${flavourUpper}-${accentUpper}-Cursors";
        package = pkgs.catppuccin-cursors.${cfg.cursor.flavour + accentUpper};
      };
  };
}

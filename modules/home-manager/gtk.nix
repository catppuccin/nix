{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) ctp mkOption types;
  cfg = config.gtk.catppuccin;
  enable = cfg.enable && config.gtk.enable;
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
        accent = ctp.mkAccentOpt "gtk cursors";
      };
    };

  config = lib.mkIf enable {
    gtk = {
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

    assertions = [
      (lib.ctp.assertXdgEnabled "gtk")
    ];

    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}

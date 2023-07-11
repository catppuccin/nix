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
    ctp.mkCatppuccinOpt "gtk" config
    // {
      accent = ctp.mkAccentOpt "gtk" config;
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
    };

  config.gtk.theme =
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
    lib.mkIf enable {
      name = "Catppuccin-${flavourUpper}-${sizeUpper}-${accentUpper}-${gtkTheme}";
      package = pkgs.catppuccin-gtk.override {
        inherit (cfg) size tweaks;
        accents = [ cfg.accent ];
        variant = cfg.flavour;
      };
    };
}

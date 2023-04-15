{ config, pkgs, lib, ... }:
let cfg = config.gtk.catppuccin;
in {
  options.gtk.catppuccin = with lib; {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for gtk";
    };
    accent = mkOption {
      type = types.enum [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow" ];
      default = config.catppuccin.accent;
      description = "Catppuccin accents for gtk";
    };
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

  config.gtk.theme = with lib;
    with builtins;
    let
      # string -> string
      # this capitalizes the first letter in a string
      # it's used to set the theme name correctly here
      mkUpper = word: (toUpper (substring 0 1 word)) + (substring 1 (stringLength word) word);

      flavourUpper = mkUpper cfg.flavour;
      accentUpper = mkUpper cfg.accent;
      sizeUpper = mkUpper cfg.size;

      # use the light gtk theme for latte
      gtkTheme = if cfg.flavour == "latte" then "Light" else "Dark";

    in mkIf cfg.enable {
      name =
        "Catppuccin-${flavourUpper}-${sizeUpper}-${accentUpper}-${gtkTheme}";
      package = pkgs.catppuccin-gtk.override {
        inherit (cfg) size tweaks;
        accents = [cfg.accent];
        variant = cfg.flavour;
      };
    };
}

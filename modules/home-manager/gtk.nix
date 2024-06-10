{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    ctp
    mkOption
    mkEnableOption
    types
    ;
  cfg = config.gtk.catppuccin;
  enable = cfg.enable && config.gtk.enable;
  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = ctp.mergeEnums ctp.types.accentOption (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in
{
  options.gtk.catppuccin = ctp.mkCatppuccinOpt "gtk" // {
    # NOTE: we are overriding the previous declaration of `enable` here
    # as this module is deprecated and we do not want it to apply with
    # the global `catppuccin.enable`
    enable = lib.mkEnableOption "Catppuccin theme";

    accent = ctp.mkAccentOpt "gtk";
    size = mkOption {
      type = types.enum [
        "standard"
        "compact"
      ];
      default = "standard";
      description = "Catppuccin size variant for gtk";
    };
    tweaks = mkOption {
      type = types.listOf (
        types.enum [
          "black"
          "rimless"
          "normal"
        ]
      );
      default = [ "normal" ];
      description = "Catppuccin tweaks for gtk";
    };
    gnomeShellTheme = mkEnableOption "Catppuccin gtk theme for GNOME Shell";

    cursor = ctp.mkCatppuccinOpt "gtk cursors" // {
      accent = ctp.mkBasicOpt "accent" cursorAccentType "gtk cursors";
    };

    icon = ctp.mkCatppuccinOpt "gtk modified Papirus icon theme" // {
      accent = ctp.mkAccentOpt "gtk modified Papirus icon theme";
    };
  };

  config = lib.mkIf enable {
    warnings = [
      ''
        `gtk.catppuccin` is deprecated and will be removed in a future release.

        The upstream port has been archived and support will no longer be provided.
        Please see https://github.com/catppuccin/gtk/issues/262
      ''
    ];

    gtk = {
      theme =
        let
          flavorUpper = ctp.mkUpper cfg.flavor;
          accentUpper = ctp.mkUpper cfg.accent;
          sizeUpper = ctp.mkUpper cfg.size;

          # use the light gtk theme for latte
          gtkTheme = if cfg.flavor == "latte" then "Light" else "Dark";
        in
        {
          name = "Catppuccin-${flavorUpper}-${sizeUpper}-${accentUpper}-${gtkTheme}";
          package = pkgs.catppuccin-gtk.override {
            inherit (cfg) size tweaks;
            accents = [ cfg.accent ];
            variant = cfg.flavor;
          };
        };

      cursorTheme =
        let
          accentUpper = ctp.mkUpper cfg.cursor.accent;
        in
        lib.mkIf cfg.cursor.enable {
          name = "catppuccin-${cfg.cursor.flavor}-${cfg.cursor.accent}-cursors";
          package = pkgs.catppuccin-cursors.${cfg.cursor.flavor + accentUpper};
        };

      iconTheme =
        let
          # use the light icon theme for latte
          polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
        in
        lib.mkIf cfg.icon.enable {
          name = "Papirus-${polarity}";
          package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
        };
    };

    xdg.configFile =
      let
        gtk4Dir = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
      in
      {
        "gtk-4.0/assets".source = "${gtk4Dir}/assets";
        "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
      };

    home.packages = lib.mkIf cfg.gnomeShellTheme [ pkgs.gnomeExtensions.user-themes ];

    dconf.settings = lib.mkIf cfg.gnomeShellTheme {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      };
      "org/gnome/shell/extensions/user-theme" = {
        inherit (config.gtk.theme) name;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = if cfg.flavor == "latte" then "default" else "prefer-dark";
      };
    };
  };
}

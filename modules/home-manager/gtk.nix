{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    mkRenamedOptionModule
    types
    ;

  cfg = config.catppuccin.gtk;
  enable = cfg.enable && config.gtk.enable;
in

{
  options.catppuccin.gtk =
    catppuccinLib.mkCatppuccinOption {
      name = "gtk";
      useGlobalEnable = false;

      accentSupport = true;
    }
    // {
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
            "float"
          ]
        );
        default = [ ];
        description = "Catppuccin tweaks for gtk";
      };

      gnomeShellTheme = mkEnableOption "Catppuccin gtk theme for GNOME Shell";

      icon = catppuccinLib.mkCatppuccinOption {
        name = "GTK modified Papirus icon theme";
        # NOTE: we exclude this from the global `catppuccin.enable` as there is no
        # `enable` option in the upstream module to guard it
        default = false;

        accentSupport = true;
      };
    };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "gtk"
        "catppuccin"
      ];
      to = "gtk";
      accentSupport = true;
    })
    ++ (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "gtk"
        "catppuccin"
        "cursor"
      ];
      to = "cursors";
      accentSupport = true;
    })
    ++ [
      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "size"
        ]
        [
          "catppuccin"
          "gtk"
          "size"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "tweaks"
        ]
        [
          "catppuccin"
          "gtk"
          "tweaks"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "gnomeShellTheme"
        ]
        [
          "catppuccin"
          "gtk"
          "gnomeShellTheme"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "icon"
        ]
        [
          "catppuccin"
          "gtk"
          "icon"
        ]
      )
    ];

  config = mkMerge [
    (mkIf (enable || cfg.gnomeShellTheme) {
      warnings = [
        ''
          `gtk.catppuccin.enable` and `gtk.catppuccin.gnomeShellTheme` are deprecated and will be removed in a future release.

          The upstream port has been archived and support will no longer be provided.
          Please see https://github.com/catppuccin/gtk/issues/262
        ''
      ];
    })

    (mkIf enable {
      gtk.theme =
        let
          gtkTweaks = "+" + concatStringsSep "," cfg.tweaks;
        in
        {
          name =
            "catppuccin-${cfg.flavor}-${cfg.accent}-${cfg.size}"
            + lib.optionalString (cfg.tweaks != [ ]) gtkTweaks;
          package = config.catppuccin.sources.gtk.override {
            inherit (cfg) flavor size tweaks;
            accents = [ cfg.accent ];
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
    })

    (mkIf cfg.icon.enable {
      gtk.iconTheme =
        let
          # use the light icon theme for latte
          polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
        in
        {
          name = "Papirus-${polarity}";
          package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
        };
    })

    (mkIf cfg.gnomeShellTheme {
      assertions = [
        {
          assertion = enable;
          message = "`gtk.enable` and `gtk.catppuccin.enable` must be `true` to use the GNOME shell theme";
        }
      ];

      home.packages = [ pkgs.gnomeExtensions.user-themes ];

      dconf.settings = {
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
    })
  ];
}

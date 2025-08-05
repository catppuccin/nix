{ catppuccinLib }:
{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib)
    mkOption
    types
    ;

  cfg = config.catppuccin.sddm;
  enable = cfg.enable && config.services.displayManager.sddm.enable;
in

{
  options.catppuccin.sddm =
    catppuccinLib.mkCatppuccinOption {
      name = "sddm";
      accentSupport = true;
    }
    // {
      font = mkOption {
        type = types.str;
        default = "Noto Sans";
        description = "Font to use for the login screen";
      };

      fontSize = mkOption {
        type = types.str;
        default = "9";
        description = "Font size to use for the login screen";
      };

      background = mkOption {
        type = with types; nullOr (either path str);
        default = "backgrounds/wall.png";
        description = "Background image to use for the login screen";
      };

      loginBackground = mkOption {
        type = types.bool;
        default = false;
        description = "Add an additional background layer to the login panel";
      };

      userIcon = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable user icon on the login screen

          To use this, you should place a file in `~/.face.icon` or `FacesDir/username.face.icon`
        '';
      };

      clockEnabled = mkOption {
        type = types.bool;
        default = true;
        description = "Enable the clock on the login screen";
      };

      assertQt6Sddm =
        lib.mkEnableOption ''
          checking if `services.displayManager.sddm.package` is the Qt 6 version.

          This is to ensure the theme is applied properly, but may have false positives in the case of overridden packages for example
        ''
        // {
          default = true;
        };
    };

  imports =[
      (lib.mkRemovedOptionModule
        [
          "catppuccin"
          "sddm"
          "accentColor"
        ]
        "The `accentColor` option is no longer used upstream, please migrate to the new `accent` option instead."
      )
    ];

  config = lib.mkIf enable {
    assertions = lib.optional cfg.assertQt6Sddm {
      assertion = config.services.displayManager.sddm.package == pkgs.kdePackages.sddm;
      message = ''
        Only the Qt 6 version of SDDM is supported by this port!

        In most cases this can be resolved by setting `services.displayManager.sddm.package`
        to `pkgs.kdePackages.sddm`. If you know what you're doing and wish to disable this check,
        please set `services.displayManager.sddm.catppuccin.assertQt6Sddm` to `false`
      '';
    };

    services.displayManager = {
      sddm = {
        theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
      };
    };

    environment.systemPackages = [
      (config.catppuccin.sources.sddm.override {
        inherit (cfg)
          font
          fontSize
          background
          loginBackground
          userIcon
          clockEnabled
          ;
      })
    ];
  };
}

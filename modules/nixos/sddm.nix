{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    ctp
    types
    mkOption
    ;
  cfg = config.services.displayManager.sddm.catppuccin;
  enable = cfg.enable && config.services.displayManager.sddm.enable;
in

{
  options.services.displayManager.sddm.catppuccin = ctp.mkCatppuccinOpt { name = "sddm"; } // {
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
      type = with types; (either path str);
      default = "";
      description = "Background image to use for the login screen";
    };

    loginBackground = mkOption {
      type = types.bool;
      default = true;
      description = "Add an additional background layer to the login panel";
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

  config = mkIf enable {
    assertions = lib.optional cfg.assertQt6Sddm {
      assertion = config.services.displayManager.sddm.package == pkgs.kdePackages.sddm;
      message = ''
        Only the Qt 6 version of SDDM is supported by this port!

        In most cases this can be resolved by setting `services.displayManager.sddm.package`
        to `pkgs.kdePackages.sddm`. If you know what you're doing and wish to disable this check,
        please set `services.displayManager.sddm.catppuccin.assertQt6Sddm` to `false`
      '';
    };

    services.displayManager.sddm.theme = "catppuccin-${cfg.flavor}";

    environment.systemPackages = [
      (config.catppuccin.sources.sddm.override {
        inherit (cfg)
          font
          fontSize
          background
          loginBackground
          ;
      })
    ];
  };
}

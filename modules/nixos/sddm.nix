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
    versionAtLeast
    ;
  cfg = config.services.displayManager.sddm.catppuccin;
  enable = cfg.enable && config.services.displayManager.sddm.enable;

  # versions >= 24.05 renamed `services.xserver.displayManager` to `services.displayManager`
  # TODO: remove when 24.05 is stable
  minVersion = "24.05";
in
{
  options.services.displayManager = ctp.mkVersionedOpts minVersion {
    sddm.catppuccin = ctp.mkCatppuccinOpt "sddm" // {
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
    };
  };

  config =
    mkIf enable {
      environment.systemPackages = [
        (pkgs.catppuccin-sddm.override {
          inherit (cfg)
            flavor
            font
            fontSize
            background
            loginBackground
            ;
        })
      ];
    }
    // mkIf (enable && versionAtLeast ctp.getModuleRelease minVersion) {
      services.displayManager.sddm.theme = "catppuccin-${cfg.flavor}";
    };
}

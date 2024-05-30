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
  options.services.displayManager.sddm.catppuccin = ctp.mkCatppuccinOpt "sddm" // {
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

  config = mkIf enable {
    services.displayManager.sddm.theme = "catppuccin-${cfg.flavor}";
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
  };
}

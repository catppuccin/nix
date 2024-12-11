{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp;
  cfg = config.programs.wlogout.catppuccin;
  enable = cfg.enable && config.programs.wlogout.enable;
in
{
  options.programs.wlogout.catppuccin = ctp.mkCatppuccinOpt { name = "wlogout"; } // {
    accent = ctp.mkAccentOpt "wlogout";
    iconStyle = lib.mkOption {
      type = lib.types.enum [
        "wlogout"
        "wleave"
      ];
      description = "Icon style to set in ~/.config/wlogout/style.css";
      default = "wlogout";
      example = lib.literalExpression "wleave";
    };
    extraStyle = lib.mkOption {
      type = lib.types.lines;
      description = "Additional CSS to put in ~/.config/wlogout/style.css";
      default = "";
      example = lib.literalExpression ''
        button {
          border-radius: 2px;
        }

        #lock {
          background-image: url("${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}/apps/scalable/system-lock-screen.svg");
        }
      '';
    };
  };

  config.programs.wlogout = lib.mkIf enable {
    style = lib.concatStrings [
      ''
        @import url("${sources.wlogout}/themes/${cfg.flavor}/${cfg.accent}.css");
      ''
      # Set icons
      (lib.concatMapStrings
        (icon: ''
          #${icon} {
            background-image: url("${sources.wlogout}/icons/${cfg.iconStyle}/${cfg.flavor}/${cfg.accent}/${icon}.svg");
          }
        '')
        [
          "hibernate"
          "lock"
          "logout"
          "reboot"
          "shutdown"
          "suspend"
        ]
      )
      cfg.extraStyle
    ];
  };
}

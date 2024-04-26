{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.i18n.inputMethod.fcitx5.catppuccin;
  enable = cfg.enable && config.i18n.inputMethod.enabled == "fcitx5";
in
{
  options.i18n.inputMethod.fcitx5.catppuccin = ctp.mkCatppuccinOpt "Fcitx5" // {
    apply = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Applies the theme by overwriting `$XDG_CONFIG_HOME/fcitx5/conf/classicui.conf`.
        If this is disabled, you must manually set the theme (e.g. by using `fcitx5-configtool`).
      '';
    };
  };

  config = lib.mkIf enable {
    assertions = [
      (ctp.assertXdgEnabled "Fcitx5")
    ];

    xdg.dataFile."fcitx5/themes/catppuccin-${cfg.flavour}" = {
      source = "${sources.fcitx5}/src/catppuccin-${cfg.flavour}";
      recursive = true;
    };

    xdg.configFile."fcitx5/conf/classicui.conf" = lib.mkIf cfg.apply ({
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection.Theme = "catppuccin-${cfg.flavour}";
      };
    });
  };
}

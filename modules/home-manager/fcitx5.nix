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
  options.i18n.inputMethod.fcitx5.catppuccin = ctp.mkCatppuccinOpt "Fcitx5";

  config = lib.mkIf enable {
    assertions = [
      (ctp.assertXdgEnabled "Fcitx5")
    ];

    xdg.dataFile."fcitx5/themes/catppuccin-${cfg.flavour}" = {
      source = "${sources.fcitx5}/src/catppuccin-${cfg.flavour}";
      recursive = true;
    };

    xdg.configFile."fcitx5/conf/classicui.conf".text = lib.generators.toINIWithGlobalSection { } {
      globalSection.Theme = "catppuccin-${cfg.flavour}";
    };
  };
}

{
  config,
  lib,
  ...
}:
let
  cfg = config.i18n.inputMethod.fcitx5.catppuccin;
  enable =
    cfg.enable
    && (
      config.i18n.inputMethod.enable or true
      && config.i18n.inputMethod.type or config.i18n.inputMethod.enabled == "fcitx5"
    );
in
{
  options.i18n.inputMethod.fcitx5.catppuccin = lib.ctp.mkCatppuccinOpt { name = "Fcitx5"; } // {
    accent = lib.ctp.mkAccentOpt "Fcitx5";
  };

  config.i18n.inputMethod.fcitx5 = lib.mkIf enable {
    addons = [ config.catppuccin.sources.fcitx5 ];
    settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
  };
}

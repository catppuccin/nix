{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.i18n.inputMethod.fcitx5.catppuccin;
  enable =
    cfg.enable
    && (
      config.i18n.inputMethod.enable or true
      && config.i18n.inputMethod.type or config.i18n.inputMethod.enabled == "fcitx5"
    );

  theme = pkgs.runCommand "catppuccin-fcitx5" { } ''
    mkdir -p $out/share/fcitx5/themes/
    cp -r ${sources.fcitx5}/src/catppuccin-${cfg.flavor}-${cfg.accent}/ $out/share/fcitx5/themes/
  '';
in
{
  options.i18n.inputMethod.fcitx5.catppuccin = lib.ctp.mkCatppuccinOpt { name = "Fcitx5"; } // {
    accent = lib.ctp.mkAccentOpt "Fcitx5";
  };

  config.i18n.inputMethod.fcitx5 = lib.mkIf enable {
    addons = [ theme ];
    settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
  };
}

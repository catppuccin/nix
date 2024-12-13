{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.i18n.inputMethod.fcitx5.catppuccin;

  theme = pkgs.runCommand "catppuccin-fcitx5" { } ''
    mkdir -p $out/share/fcitx5/themes/
    cp -r ${sources.fcitx5}/src/catppuccin-${cfg.flavor}-${cfg.accent}/ $out/share/fcitx5/themes/
  '';
in

{
  options.i18n.inputMethod.fcitx5.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "Fcitx5";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod.fcitx5 = {
      addons = [ theme ];
      settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
    };
  };
}

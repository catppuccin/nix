{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.fcitx5;
in

{
  options.catppuccin.fcitx5 = catppuccinLib.mkCatppuccinOption {
    name = "Fcitx5";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "i18n"
      "inputMethod"
      "fcitx5"
      "catppuccin"
    ];
    to = "fcitx5";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod.fcitx5 = {
      addons = [ config.catppuccin.sources.fcitx5 ];
      settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
    };
  };
}

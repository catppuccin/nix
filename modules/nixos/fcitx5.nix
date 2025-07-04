{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.fcitx5;
in

{
  options.catppuccin.fcitx5 =
    catppuccinLib.mkCatppuccinOption {
      name = "Fcitx5";
      accentSupport = true;
    }
    // {
      enableRounded = lib.mkEnableOption "rounded corners for the Fcitx5 theme";
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
      addons = [
        (sources.fcitx5.override { inherit (cfg) enableRounded; })
      ];
      settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fcitx5;
  enable =
    cfg.enable
    && (
      (
        config.i18n.inputMethod ? enable
        && config.i18n.inputMethod.enable
        && config.i18n.inputMethod.type == "fcitx5"
      )
      || config.i18n.inputMethod.enabled == "fcitx5"
    );
in

{
  options.catppuccin.fcitx5 =
    catppuccinLib.mkCatppuccinOption {
      name = "Fcitx5";
      accentSupport = true;
    }
    // {
      apply = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Applies the theme by overwriting `$XDG_CONFIG_HOME/fcitx5/conf/classicui.conf`.
          If this is disabled, you must manually set the theme (e.g. by using `fcitx5-configtool`).
        '';
      };

      enableRounded = lib.mkEnableOption "rounded corners for the Fcitx5 theme";
    };

  config = lib.mkIf enable {
    i18n.inputMethod.fcitx5 = {
      addons = [
        (sources.fcitx5.override { inherit (cfg) enableRounded; })
      ];
      settings.addons.classicui.globalSection.Theme = "catppuccin-${cfg.flavor}-${cfg.accent}";
    };
  };
}

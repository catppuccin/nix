{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.qt.style.catppuccin;
  enable =
    cfg.enable
    && config.qt.enable
    && lib.elem config.qt.style.name [
      "kvantum"
      "Kvantum"
    ];
  flavorCapitalized = lib.ctp.mkUpper cfg.flavor;
  accentCapitalized = lib.ctp.mkUpper cfg.accent;
  theme = pkgs.catppuccin-kvantum.override {
    accent = accentCapitalized;
    variant = flavorCapitalized;
  };
  themeName = "Catppuccin-${flavorCapitalized}-${accentCapitalized}";
in
{
  options.qt.style.catppuccin = lib.ctp.mkCatppuccinOpt "Kvantum" // {
    accent = lib.ctp.mkAccentOpt "Kvantum";

    apply = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Applies the theme by overwriting `$XDG_CONFIG_HOME/Kvantum/kvantum.kvconfig`.
        If this is disabled, you must manually set the theme (e.g. by using `kvantummanager`).
      '';
    };
  };

  config.xdg.configFile = lib.mkIf enable {
    "Kvantum/${themeName}".source = "${theme}/share/Kvantum/${themeName}";
    "Kvantum/kvantum.kvconfig" = lib.mkIf cfg.apply {
      text = ''
        [General]
        theme=${themeName}
      '';
    };
  };
}

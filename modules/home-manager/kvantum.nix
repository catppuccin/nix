{
  config,
  lib,
  ...
}:
let
  cfg = config.qt.style.catppuccin;
  enable = cfg.enable && config.qt.enable;

  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}";
in
{
  options.qt.style.catppuccin = lib.ctp.mkCatppuccinOpt { name = "Kvantum"; } // {
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

  config = lib.mkIf enable {
    assertions = [
      {
        assertion = lib.elem config.qt.style.name [
          "kvantum"
          "Kvantum"
        ];
        message = ''`qt.style.name` must be `"kvantum"` to use `qt.style.catppuccin`'';
      }
      {
        assertion = lib.elem (config.qt.platformTheme.name or null) [ "kvantum" ];
        message = ''`qt.platformTheme.name` must be set to `"kvantum"` to use `qt.style.catppuccin`'';
      }
    ];

    xdg.configFile = {
      "Kvantum/${themeName}".source = "${config.catppuccin.sources.kvantum}/share/Kvantum/${themeName}";
      "Kvantum/kvantum.kvconfig" = lib.mkIf cfg.apply {
        text = ''
          [General]
          theme=${themeName}
        '';
      };
    };
  };
}

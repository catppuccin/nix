{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.catppuccin.kvantum;
  enable = cfg.enable && config.qt.enable;

  theme = pkgs.catppuccin-kvantum.override {
    inherit (cfg) accent;
    variant = cfg.flavor;
  };

  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}";
in
{
  options.catppuccin.kvantum =
    catppuccinLib.mkCatppuccinOption {
      name = "Kvantum";
      accentSupport = true;
    }
    // {
      apply = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Applies the theme by overwriting `$XDG_CONFIG_HOME/Kvantum/kvantum.kvconfig`.
          If this is disabled, you must manually set the theme (e.g. by using `kvantummanager`).
        '';
      };
    };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOpts {
      from = [
        "qt"
        "style"
        "catppuccin"
      ];
      to = "kvantum";
      accentSupport = true;
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "qt"
          "style"
          "catppuccin"
          "apply"
        ]
        [
          "catppuccin"
          "kvantum"
          "apply"
        ]
      )
    ];

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
      "Kvantum/${themeName}".source = "${theme}/share/Kvantum/${themeName}";
      "Kvantum/kvantum.kvconfig" = lib.mkIf cfg.apply {
        text = ''
          [General]
          theme=${themeName}
        '';
      };
    };
  };
}

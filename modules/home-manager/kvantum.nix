{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.kvantum;
  enable = cfg.enable && config.qt.enable;

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
    (catppuccinLib.mkRenamedCatppuccinOptions {
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

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
      assertStyle = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = ''
          Whether to assert that {option}`qt.style.name` is set to `"kvantum"` when Kvantum themes are enabled.
        '';
      };
    };

  config = lib.mkIf enable {
    assertions = lib.mkIf cfg.assertStyle [
      {
        assertion = lib.elem config.qt.style.name [
          "kvantum"
          "Kvantum"
        ];
        message = ''`qt.style.name` must be `"kvantum"` to use `qt.style.catppuccin`'';
      }
    ];

    qt.kvantum = {
      enable = true;
      settings.General.theme = themeName;
      themes = [ config.catppuccin.sources.kvantum ];
    };
  };
}

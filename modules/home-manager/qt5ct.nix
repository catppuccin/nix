{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.qt5ct;
  enable = cfg.enable && config.qt.enable;
in

{
  options.catppuccin.qt5ct =
    catppuccinLib.mkCatppuccinOption {
      name = "qt5ct";
      accentSupport = true;

      # NOTE: don't default enable since it will conflict with kvantum themes
      # at least for the extent of qt.style.name
      useGlobalEnable = false;
    }
    // {
      assertStyle = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = false;
        description = ''
          Whether to assert that {option}`qt.style.name` is set to `"qtct"` when qtct themes are enabled.
        '';
      };
    };

  config = lib.mkIf enable {
    assertions = lib.mkIf cfg.assertStyle [
      {
        assertion = config.qt.platformTheme.name == "qtct";
        message = ''{option}`qt.platformTheme.name` must be `"qtct"` to use {option}`catppuccin.qt5ct`'';
      }
    ];

    qt = lib.genAttrs [ "qt5ctSettings" "qt6ctSettings" ] (_: {
      Appearance = {
        custom_palette = true;
        color_scheme_path = "${config.catppuccin.sources.qt5ct}/catppuccin-${cfg.flavor}-${cfg.accent}.conf";
      };
    });
  };
}

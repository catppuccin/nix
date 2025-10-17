{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cursors;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = lib.types.mergeTypes catppuccinLib.types.accent (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in

{
  options.catppuccin.cursors =
    (catppuccinLib.mkCatppuccinOption {
      name = "pointer cursors";
      # NOTE: We exclude this as there is no `enable` option in the upstream
      # module to guard it
      useGlobalEnable = false;
    })
    // {
      accent = lib.mkOption {
        type = cursorAccentType;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for pointer cursors";
      };
    };

  config =
    lib.mkIf
      (
        cfg.enable
        && (config.services.desktopManager.gnome.enable || config.services.displayManager.gdm.enable)
      )
      {
        environment.systemPackages = [
          sources.cursors
        ];

        programs.dconf.profiles.gdm.databases = [
          {
            lockAll = true;
            settings."org/gnome/desktop/interface" = {
              cursor-theme = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
            };
          }
        ];
      };
}

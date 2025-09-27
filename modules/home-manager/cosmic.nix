{ catppuccinLib }:
{ config, lib, ... }:
{
  options.catppuccin = {
    cosmic = catppuccinLib.mkCatppuccinOption {
      accentSupport = true;
      name = "cosmic";
    };

    cosmic-term = catppuccinLib.mkCatppuccinOption { name = "cosmic-term"; };
  };

  config =
    let
      cfg = config.catppuccin;
      version = 1;
    in
    lib.mkMerge [
      (lib.mkIf cfg.cosmic.enable {
        wayland.desktopManager.cosmic.components.config = {
          "com.system76.CosmicTheme.${if cfg.cosmic.flavor == "latte" then "Light" else "Dark"}.Builder" = {
            inherit version;
            entries = lib.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/cosmic-settings/catppuccin-${cfg.cosmic.flavor}-${cfg.cosmic.accent}+round.ron";
          };

          "com.system76.CosmicTheme.Mode" = {
            inherit version;
            entries.is_dark = cfg.cosmic.flavor != "latte";
          };
        };
      })

      (lib.mkIf cfg.cosmic-term.enable
        {
          # TODO
        }
      )
    ];
}

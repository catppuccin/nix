{ catppuccinLib }:
{ config, lib, ... }:
{
  options.catppuccin = {
    cosmic-desktop = catppuccinLib.mkCatppuccinOption {
      accentSupport = true;
      name = "cosmic-desktop";
    };

    cosmic-term = catppuccinLib.mkCatppuccinOption { name = "cosmic-term"; };
  };

  config =
    let
      cfg = config.catppuccin;
    in
    lib.mkMerge [
      (lib.mkIf cfg.cosmic-desktop.enable {
        wayland.desktopManager.cosmic.components.config =
          let
            version = 1;
          in
          {
            "com.system76.CosmicTheme.Dark.Builder" = {
              inherit version;
              entries = lib.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/themes/cosmic-settings/catppuccin-${cfg.cosmic-desktop.flavor}-${cfg.cosmic-desktop.accent}+round.ron";
            };

            "com.system76.CosmicTheme.Light.Builder" = {
              inherit version;
              entries = lib.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/themes/cosmic-settings/catppuccin-latte-${cfg.cosmic-desktop.accent}+round.ron";
            };

            "com.system76.CosmicTheme.Mode" = {
              inherit version;
              entries.is_dark = cfg.cosmic-desktop.flavor != "latte";
            };
          };
      })

      (lib.mkIf cfg.cosmic-term.enable {
        wayland.desktopManager.cosmic.components.config."com.system76.CosmicTerm" = {
          version = 1;

          entries =
            let
              existingDark =
                config.wayland.desktopManager.cosmic.components.config."com.system76.CosmicTerm".entries.color_schemes_dark.attrs
                  or [ ];
              existingLight =
                config.wayland.desktopManager.cosmic.components.config."com.system76.CosmicTerm".entries.color_schemes_light.attrs
                  or [ ];
              maxDarkKey =
                if existingDark == [ ] then -1 else lib.foldl lib.max (-1) (map (t: t.key) existingDark);
              maxLightKey =
                if existingLight == [ ] then -1 else lib.foldl lib.max (-1) (map (t: t.key) existingLight);
              darkTheme = lib.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/themes/cosmic-term/catppuccin-${cfg.cosmic-term.flavor}.ron";
              lightTheme = lib.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/themes/cosmic-term/catppuccin-latte.ron";
            in
            {
              color_schemes_dark = lib.ron.mkMap (
                existingDark
                ++ [
                  {
                    key = maxDarkKey + 1;
                    value = darkTheme;
                  }
                ]
              );
              color_schemes_light = lib.ron.mkMap (
                existingLight
                ++ [
                  {
                    key = maxLightKey + 1;
                    value = lightTheme;
                  }
                ]
              );
              syntax_theme_dark = darkTheme.name;
              syntax_theme_light = lightTheme.name;
            };
        };
      })
    ];
}

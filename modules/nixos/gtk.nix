{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.catppuccin.gtk;
in
{
  options.catppuccin.gtk = {
    icon = catppuccinLib.mkCatppuccinOption {
      name = "GTK modified Papirus icon theme";

      accentSupport = true;
    };
  };

  config =
    lib.mkIf
      (
        cfg.icon.enable
        && (config.services.desktopManager.gnome.enable || config.services.displayManager.gdm.enable)
      )
      {
        services.displayManager.environment.XDG_DATA_DIRS = (
          (lib.makeSearchPath "share" [
            (pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; })
          ])
          + ":"
        );

        programs.dconf.profiles.gdm.databases = [
          {
            lockAll = true;
            settings."org/gnome/desktop/interface" =
              let
                # use the light icon theme for latte
                polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
              in
              {
                icon-theme = "Papirus-${polarity}";
              };
          }
        ];
      };
}

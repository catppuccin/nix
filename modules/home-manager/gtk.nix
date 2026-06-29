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

  config = lib.mkIf (config.catppuccin.enable && cfg.icon.enable) {
    gtk.iconTheme =
      let
        # use the light icon theme for latte
        polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
      in
      {
        name = "Papirus-${polarity}";
        package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
      };
  };
}

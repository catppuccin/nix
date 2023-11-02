{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.btop.catppuccin;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavour}.theme";
  themePath = "/themes/${themeFile}";
  theme = sources.btop + themePath;
in
{
  options.programs.btop.catppuccin =
    lib.ctp.mkCatppuccinOpt "btop";

  config = lib.mkIf enable
    {
      xdg = {
        # xdg is required for this to work
        enable = lib.mkForce true;
        configFile."btop${themePath}".source = theme;
      };

      programs.btop.settings.color_theme = themeFile;
    };
}

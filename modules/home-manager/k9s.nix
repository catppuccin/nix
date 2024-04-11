{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.k9s.catppuccin;
  enable = cfg.enable && config.programs.k9s.enable;

  themeFile = "catppuccin-${cfg.flavour}.yaml";
  themePath = "/skins/${themeFile}";
  theme = sources.k9s + "/dist/${themeFile}";
in
{
  options.programs.k9s.catppuccin =
    lib.ctp.mkCatppuccinOpt "k9s";

  config = lib.mkIf enable
    {
      assertions = [
        (lib.ctp.assertXdgEnabled "k9s")
      ];

      xdg.configFile."k9s${themePath}".source = theme;

      programs.k9s.settings.k9s.ui.skin = "catppuccin-${cfg.flavour}";
    };
}

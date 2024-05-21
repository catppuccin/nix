{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.k9s.catppuccin;
  enable = cfg.enable && config.programs.k9s.enable;

  themeName = "catppuccin-${cfg.flavour}" + lib.optionalString cfg.transparent "-transparent";
  themeFile = "${themeName}.yaml";
  themePath = "/skins/${themeFile}";
  theme = sources.k9s + "/dist/${themeFile}";
in
{
  options.programs.k9s.catppuccin = lib.ctp.mkCatppuccinOpt "k9s" // {
    transparent = lib.mkEnableOption "transparent version of flavour";
  };

  config = lib.mkIf enable {
    xdg.configFile."k9s${themePath}".source = theme;

    programs.k9s.settings.k9s.ui.skin = themeName;
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.catppuccin) sources;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  cfg = config.programs.k9s.catppuccin;
  enable = cfg.enable && config.programs.k9s.enable;

  themeName = "catppuccin-${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
  themeFile = "${themeName}.yaml";
  configDirectory =
    if (isDarwin && !config.xdg.enable)
    then "/Library/Application Support/k9s"
    else "k9s";
  themePath = "${configDirectory}/skins/${themeFile}";
  theme = sources.k9s + "/dist/${themeFile}";
in {
  options.programs.k9s.catppuccin =
    lib.ctp.mkCatppuccinOpt {name = "k9s";}
    // {
      transparent = lib.mkEnableOption "transparent version of flavor";
    };

  config = lib.mkIf enable {
    xdg.configFile."${themePath}".source = theme;

    programs.k9s.settings.k9s.ui.skin = themeName;
  };
}

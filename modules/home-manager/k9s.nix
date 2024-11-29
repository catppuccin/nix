{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.k9s.catppuccin;
  enable = cfg.enable && config.programs.k9s.enable;

  # NOTE: On MacOS specifically, k9s expects its configuration to be in
  # `~/Library/Application Support` when not using XDG
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;

  themeName = "catppuccin-${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
  themeFile = "${themeName}.yaml";
  themePath = "k9s/skins/${themeFile}";
  theme = sources.k9s + "/${themeFile}";
in
{
  options.programs.k9s.catppuccin = lib.ctp.mkCatppuccinOpt { name = "k9s"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  config = lib.mkIf enable (
    lib.mkMerge [
      (lib.mkIf (!enableXdgConfig) {
        home.file."Library/Application Support/${themePath}".source = theme;
      })
      (lib.mkIf enableXdgConfig { xdg.configFile.${themePath}.source = theme; })
      { programs.k9s.settings.k9s.ui.skin = themeName; }
    ]
  );
}

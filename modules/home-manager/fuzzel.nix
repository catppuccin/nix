{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fuzzel.catppuccin;

  themeFile = sources.fuzzel + "/themes/${cfg.flavor}.ini";
  palette = (lib.importJSON (sources.palette + "/palette.json")).${cfg.flavor}.colors;

  colors = {
    match = palette.${cfg.accent}.hex + "ff";
    select-match = colors.match;
  };
in
{
  options.programs.fuzzel.catppuccin = lib.ctp.mkCatppuccinOpt { name = "fuzzel"; } // {
    accent = lib.ctp.mkAccentOpt "fuzzel";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.settings = lib.mkMerge [
      (lib.ctp.fromINI themeFile)
      colors
    ];
  };
}

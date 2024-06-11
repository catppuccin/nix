{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.fuzzel.catppuccin;
  enable = cfg.enable && config.programs.fuzzel.enable;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in
{
  options.programs.fuzzel.catppuccin = lib.ctp.mkCatppuccinOpt "fuzzel";

  config.programs.fuzzel.settings.colors = lib.mkIf enable {
    background = palette."${cfg.base}".hex + "dd";
    text = palette."${cfg.text}".hex + "ff";
    match = palette."${cfg.red}".hex + "ff";
    selection = palette."${cfg.surface2}".hex + "ff";
    selection-match = palette."${cfg.red}".hex + "ff";
    selection-text = palette."${cfg.text}".hex + "ff";
    border = palette."${cfg.accent}".hex + "ff";
  };
}

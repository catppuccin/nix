{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fuzzel.catppuccin;
  enable = cfg.enable && config.programs.fuzzel.enable;
in
{
  options.programs.fuzzel.catppuccin = lib.ctp.mkCatppuccinOpt { name = "fuzzel"; } // {
    accent = lib.ctp.mkAccentOpt "fuzzel";
  };

  config = lib.mkIf enable {
    programs.fuzzel.settings.main.include = sources.fuzzel + "/themes/${cfg.flavor}/${cfg.accent}.ini";
  };
}

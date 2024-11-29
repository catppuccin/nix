{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fuzzel.catppuccin;
in
{
  options.programs.fuzzel.catppuccin = lib.ctp.mkCatppuccinOpt { name = "fuzzel"; } // {
    accent = lib.ctp.mkAccentOpt "fuzzel";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.settings.main.include =
      sources.fuzzel + "/catppuccin-${cfg.flavor}/${cfg.accent}.ini";
  };
}

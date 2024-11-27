{ catppuccinLib }: 
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.fuzzel.catppuccin;
in
{
  options.programs.fuzzel.catppuccin = catppuccinLib.mkCatppuccinOption {
    name = "fuzzel";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.settings.main.include =
      sources.fuzzel + "/themes/catppuccin-${cfg.flavor}/${cfg.accent}.ini";
  };
}

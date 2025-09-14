{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin.vivid;
in
{
  options.catppuccin.vivid = catppuccinLib.mkCatppuccinOption { name = "vivid"; };

  config = lib.mkIf cfg.enable {
    programs.vivid.activeTheme = "catppuccin-${cfg.flavor}";
  };
}

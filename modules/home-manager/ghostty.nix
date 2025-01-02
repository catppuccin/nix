{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.ghostty;
in
{
  options.catppuccin.ghostty = catppuccinLib.mkCatppuccinOption { name = "ghostty"; };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      themes = {
        "catppuccin-${cfg.flavor}" =
          catppuccinLib.importINI "${config.catppuccin.sources.ghostty}/catppuccin-${cfg.flavor}.conf";
      };

      settings = {
        theme = "light:catppuccin-${cfg.flavor},dark:catppuccin-${cfg.flavor}";
      };
    };
  };
}

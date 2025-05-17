{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (catppuccinLib) mkUpper;

  cfg = config.catppuccin.vesktop;
  themeName = "catppuccin-${cfg.flavor}-${cfg.accent}.theme";
in

{
  options.catppuccin.vesktop = catppuccinLib.mkCatppuccinOption {
    name = "vesktop";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.vesktop.vencord = {
      settings.enabledThemes = [ "${themeName}.css" ];
      themes."${themeName}" = ''
        /**
         * @name Catppuccin ${
           if cfg.flavor == "frappe" then "Frappé" else mkUpper cfg.flavor
         } (${mkUpper cfg.accent})
         * @author Catppuccin
         * @description 🎮 Soothing pastel theme for Discord
         * @website https://github.com/catppuccin/discord
        **/
        @import url("https://catppuccin.github.io/discord/dist/${themeName}.css");
      '';
    };
  };
}

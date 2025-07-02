{ catppuccinLib }:
{ config, lib, ... }:

let
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
         * @name Catppuccin ${catppuccinLib.mkFlavorName cfg.flavor} (${lib.toSentenceCase cfg.accent})
         * @author Catppuccin
         * @description 🎮 Soothing pastel theme for Discord
         * @website https://github.com/catppuccin/discord
        **/
        @import url("https://catppuccin.github.io/discord/dist/${themeName}.css");
      '';
    };
  };
}

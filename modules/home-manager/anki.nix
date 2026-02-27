{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.catppuccin.anki;
in

{
  options.catppuccin.anki = catppuccinLib.mkCatppuccinOption { name = "anki"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.anki = {
      addons = with pkgs.ankiAddons; [
        (recolor.withConfig {
          config =
            let
              polarity = if config.catppuccin.flavor == "latte" then "light" else "dark";
              flavor = lib.toSentenceCase config.catppuccin.flavor;
              version = builtins.splitVersion recolor.version;
            in
            (lib.importJSON "${recolor}/share/anki/addons/recolor/themes/(${polarity}) Catppuccin ${flavor}.json")
            // {
              version = {
                major = lib.toInt (builtins.elemAt version 0);
                minor = lib.toInt (builtins.elemAt version 1);
              };
            };
        })
      ];
    };
  };
}

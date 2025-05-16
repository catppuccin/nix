{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (catppuccinLib) mkUpper;
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.element-desktop;
in

{
  options.catppuccin.element-desktop = catppuccinLib.mkCatppuccinOption { name = "element-desktop"; };

  config = lib.mkIf cfg.enable {
    programs.element-desktop = {
      settings = {
        default_theme =
          "custom-Catppuccin " + (if cfg.flavor == "frappe" then "Frappé" else mkUpper cfg.flavor);
        setting_defaults.custom_themes = [
          (lib.importJSON "${sources.element}/Catppuccin-${cfg.flavor}.json")
        ];
      };
    };
  };
}

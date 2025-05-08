{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) mkUpper;
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.element;
in

{
  options.catppuccin.element = catppuccinLib.mkCatppuccinOption {
    name = "element";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.element-desktop = {
      settings = {
        default_theme =
          "Catppuccin "
          + (if cfg.flavor == "frappe" then "Frappé" else mkUpper cfg.flavor)
          + " (${mkUpper cfg.accent})";
        setting_defaults.custom_themes = [
          (lib.importJSON "${sources.element}/catppuccin-${cfg.flavor}/catppuccin-${cfg.flavor}-${cfg.accent}.json")
        ];
      };
    };
  };
}

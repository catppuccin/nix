{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.element-desktop;
in

{
  options.catppuccin.element-desktop = catppuccinLib.mkCatppuccinOption {
    name = "element-desktop";
    accentSupport = true;
    default = lib.versionAtLeast config.home.stateVersion "25.05" && config.catppuccin.enable;
  };

  config = lib.mkIf cfg.enable {
    assertions = [ (catppuccinLib.assertMinimumVersion "25.05") ];
    programs.element-desktop = {
      settings = {
        default_theme =
          "custom-Catppuccin "
          + (if cfg.flavor == "frappe" then "Frappé" else catppuccinLib.mkUpper cfg.flavor)
          + " (${catppuccinLib.mkUpper cfg.accent})";
        setting_defaults.custom_themes = [
          (lib.importJSON "${sources.element}/${cfg.flavor}/${cfg.accent}.json")
        ];
      };
    };
  };
}

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
  };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.element-desktop = {
      settings =
        let
          custom-theme = lib.importJSON "${sources.element}/${cfg.flavor}/${cfg.accent}.json";
        in
        {
          default_theme = custom-theme.name;
          setting_defaults.custom_themes = [ custom-theme ];
        };
    };
  };
}

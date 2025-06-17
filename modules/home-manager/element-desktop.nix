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

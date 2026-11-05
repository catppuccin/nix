{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.kitty;
in

{
  options.catppuccin.kitty = catppuccinLib.mkCatppuccinOption {
    name = "kitty";
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.kitty = {
      themeFile = "Catppuccin-${lib.toSentenceCase cfg.flavor}";
      font = lib.mkIf (cfg.font != null) {
        name = lib.mkDefault cfg.font;
        size = lib.mkIf (cfg.fontSize != null) (lib.mkDefault cfg.fontSize);
        package = lib.mkIf (config.catppuccin.fontPackage != null) (
          lib.mkDefault config.catppuccin.fontPackage
        );
      };
    };
  };
}

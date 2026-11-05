{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.tofi;
in

{
  options.catppuccin.tofi = catppuccinLib.mkCatppuccinOption {
    name = "tofi";
    fontSupport = true;
  };

  config = lib.mkIf (config.catppuccin.enable && cfg.enable) {
    programs.tofi = {
      settings = {
        include = sources.tofi + "/catppuccin-${cfg.flavor}";
        font = lib.mkIf (cfg.font != null) (lib.mkDefault cfg.font);
        font-size = lib.mkIf (cfg.fontSize != null) (lib.mkDefault (toString cfg.fontSize));
      };
    };
  };
}

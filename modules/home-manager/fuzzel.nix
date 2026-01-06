{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fuzzel;
in

{
  options.catppuccin.fuzzel = catppuccinLib.mkCatppuccinOption {
    name = "fuzzel";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      settings = {
        main.include = sources.fuzzel + "/catppuccin-${cfg.flavor}/${cfg.accent}.ini";
      };
    };
  };
}

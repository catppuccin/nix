{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.mangohud;
in

{
  options.catppuccin.mangohud = catppuccinLib.mkCatppuccinOption { name = "mangohud"; };

  config = lib.mkIf cfg.enable {
    xdg.configFile = lib.mkIf config.programs.mangohud.enable {
      "MangoHud/MangoHud.conf".source = "${sources.mangohud}/${cfg.flavor}/MangoHud.conf";
    };
  };
}

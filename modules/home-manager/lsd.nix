{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.lsd;
in

{
  options.catppuccin.lsd = catppuccinLib.mkCatppuccinOption { name = "lsd"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "lsd"
      "catppuccin"
    ];
    to = "lsd";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "lsd/config.yaml".source = "${sources.lsd}/catppuccin-${cfg.flavor}/colors.yaml";
    };
    programs.lsd.settings.color.theme = "custom";
  };
}

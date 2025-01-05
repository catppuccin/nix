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
    programs.lsd.colors = catppuccinLib.importYAML "${sources.lsd}/catppuccin-${cfg.flavor}/colors.yaml";
  };
}

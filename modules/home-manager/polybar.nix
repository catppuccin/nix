{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.polybar;
in

{
  options.catppuccin.polybar = catppuccinLib.mkCatppuccinOption { name = "polybar"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "services"
      "polybar"
      "catppuccin"
    ];
    to = "polybar";
  };

  config = lib.mkIf cfg.enable {
    services.polybar = {
      extraConfig = lib.fileContents "${sources.polybar}/${cfg.flavor}.ini";
    };
  };
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.glamour;
in

{
  options.catppuccin.glamour = catppuccinLib.mkCatppuccinOption { name = "glamour"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "glamour"
      "catppuccin"
    ];
    to = "glamour";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GLAMOUR_STYLE = "${sources.glamour}/catppuccin-${cfg.flavor}.json";
    };
  };
}

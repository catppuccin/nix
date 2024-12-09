{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.glamour;
  inherit (cfg) enable;
in
{
  options.catppuccin.glamour = lib.ctp.mkCatppuccinOpt { name = "glamour"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "glamour"
      "catppuccin"
    ];
    to = "glamour";
  };

  config = {
    home.sessionVariables = lib.mkIf enable {
      GLAMOUR_STYLE = "${sources.glamour}/themes/catppuccin-${cfg.flavor}.json";
    };
  };
}

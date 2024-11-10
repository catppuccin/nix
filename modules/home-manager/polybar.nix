{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.polybar;
  enable = cfg.enable && config.services.polybar.enable;
in
{
  options.catppuccin.polybar = lib.ctp.mkCatppuccinOpt { name = "polybar"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "services"
      "polybar"
      "catppuccin"
    ];
    to = "polybar";
  };

  config.services.polybar.extraConfig = lib.mkIf enable (
    builtins.readFile "${sources.polybar}/themes/${cfg.flavor}.ini"
  );
}

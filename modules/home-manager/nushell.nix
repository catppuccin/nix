{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.nushell;
in

{
  options.catppuccin.nushell = catppuccinLib.mkCatppuccinOption { name = "nushell"; };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.nushell = {
      extraConfig = lib.mkBefore ''
        source ${sources.nushell + "/catppuccin_${cfg.flavor}.nu"}
      '';
    };
  };
}

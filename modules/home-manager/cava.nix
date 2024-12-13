{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.cava.catppuccin;
  flavor = "${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
in

{
  options.programs.cava.catppuccin = catppuccinLib.mkCatppuccinOption { name = "cava"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  config = lib.mkIf cfg.enable {
    programs.cava = {
      settings = catppuccinLib.fromINIRaw (sources.cava + "/themes/${flavor}.cava");
    };
  };
}

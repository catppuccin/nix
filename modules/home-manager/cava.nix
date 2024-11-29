{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.cava.catppuccin;
  enable = cfg.enable && config.programs.cava.enable;
  flavor = "${cfg.flavor}" + lib.optionalString cfg.transparent "-transparent";
in
{
  options.programs.cava.catppuccin = lib.ctp.mkCatppuccinOpt { name = "cava"; } // {
    transparent = lib.mkEnableOption "transparent version of flavor";
  };

  config.programs.cava = lib.mkIf enable {
    settings = lib.ctp.fromINIRaw (sources.cava + "/${flavor}.cava");
  };
}

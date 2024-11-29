{ config, lib, ... }:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;

  cfg = config.programs.rio.catppuccin;
  enable = cfg.enable && config.programs.rio.enable;
in
{
  options.programs.rio.catppuccin = ctp.mkCatppuccinOpt { name = "rio"; };

  config = lib.mkIf enable {
    programs.rio.settings = lib.importTOML "${sources.rio}/catppuccin-${cfg.flavor}.toml";
  };
}

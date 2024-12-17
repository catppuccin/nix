{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.bottom.catppuccin;
  enable = cfg.enable && config.programs.bottom.enable;
in
{
  options.programs.bottom.catppuccin = lib.ctp.mkCatppuccinOption { name = "bottom"; };

  config = lib.mkIf enable {
    programs.bottom = {
      settings = lib.importTOML "${sources.bottom}/themes/${cfg.flavor}.toml";
    };
  };
}

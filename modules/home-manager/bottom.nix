{ config
, lib
, sources
, ...
}:
let
  inherit (builtins) fromTOML readFile;
  cfg = config.programs.bottom.catppuccin;
  enable = cfg.enable && config.programs.bottom.enable;
in
{
  options.programs.bottom.catppuccin =
    lib.ctp.mkCatppuccinOpt "bottom" config;

  config.programs.bottom.settings = lib.mkIf enable (fromTOML (readFile "${sources.bottom}/themes/${cfg.flavour}.toml"));
}

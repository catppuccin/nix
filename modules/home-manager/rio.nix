{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.rio.catppuccin;
  enable = cfg.enable && config.programs.rio.enable;
in
{
  options.programs.rio.catppuccin =
    ctp.mkCatppuccinOpt "rio";

  config = lib.mkIf enable {
    programs.rio.settings = lib.importTOML "${sources.rio}/catppuccin-${cfg.flavour}.toml";
  };
}

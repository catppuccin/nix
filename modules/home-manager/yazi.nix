{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.programs.yazi.catppuccin =
    ctp.mkCatppuccinOpt "yazi";

  config = lib.mkIf enable {
    programs.yazi.theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavour}.toml";
  };
}

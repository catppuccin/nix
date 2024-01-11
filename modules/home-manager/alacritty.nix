{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.alacritty.catppuccin;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.programs.alacritty.catppuccin =
    ctp.mkCatppuccinOpt "alacritty";

  config = lib.mkIf enable {
    programs.alacritty.settings = lib.importTOML "${sources.alacritty}/catppuccin-${cfg.flavour}.toml";
  };
}

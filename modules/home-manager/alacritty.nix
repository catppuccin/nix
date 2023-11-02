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

  config.programs.alacritty.settings =
    let
      file = "${sources.alacritty}/catppuccin-${cfg.flavour}.yml";
    in
    lib.mkIf enable (ctp.fromYaml file);
}

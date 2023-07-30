{ config
, lib
, pkgs
, sources
, ...
}:
let
  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;
in
{
  options.programs.lazygit.catppuccin =
    lib.ctp.mkCatppuccinOpt "lazygit" config;

  config.programs.lazygit.settings =
    let
      file = "${sources.lazygit}/themes/${cfg.flavour}.yml";
    in
    lib.mkIf enable (lib.ctp.fromYaml pkgs file);
}

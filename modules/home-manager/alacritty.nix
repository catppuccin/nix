{ config
, pkgs
, lib
, inputs
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.alacritty.catppuccin;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.programs.alacritty.catppuccin =
    ctp.mkCatppuccinOpt "alacritty" config;

  config.programs.alacritty.settings =
    let
      file = "${inputs.alacritty}/catppuccin-${cfg.flavour}.yml";
    in
    lib.mkIf enable (ctp.fromYaml pkgs file);
}

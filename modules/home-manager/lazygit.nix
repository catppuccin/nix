{ config
, lib
, pkgs
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;

  themePath = "/${cfg.flavour}/${cfg.accent}.yml";
in
{
  options.programs.lazygit.catppuccin =
    lib.ctp.mkCatppuccinOpt "lazygit" config // {
      accent = ctp.mkAccentOpt "lazygit" config;

    };

  config = lib.mkIf enable {

    programs.lazygit.settings =
      let
        file = "${sources.lazygit}/themes/${themePath}";
      in
      lib.ctp.fromYaml pkgs file;
  };
}

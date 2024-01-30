{ config
, lib
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
    lib.ctp.mkCatppuccinOpt "lazygit" // {
      accent = ctp.mkAccentOpt "lazygit";

    };

  config = lib.mkIf enable {

    programs.lazygit.settings = lib.ctp.fromYaml "${sources.lazygit}/themes-mergable/${themePath}";
  };
}

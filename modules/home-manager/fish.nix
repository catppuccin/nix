{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.programs.fish.catppuccin;
  enable = cfg.enable && config.programs.fish.enable;

  theme = pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "fish";
      rev = "91e6d6721362be05a5c62e235ed8517d90c567c9";
      sha256 = "sha256-l9V7YMfJWhKDL65dNbxaddhaM6GJ0CFZ6z+4R6MJwBA=";
    };
  themeName = "Catppuccin ${ctp.mkUpper cfg.flavour}";
in
{
  options.programs.fish.catppuccin = lib.ctp.mkCatppuccinOpt "fish" config;

  # xdg is required for this to work
  config = mkIf enable {
    xdg.enable = lib.mkForce true;

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
    xdg.configFile."fish/themes/${themeName}.theme".source = "${theme}/themes/${themeName}.theme";
  };
}

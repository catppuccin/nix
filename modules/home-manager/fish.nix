{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.programs.fish.catppuccin;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${ctp.mkUpper cfg.flavour}";
  themePath = "/themes/${themeName}.theme";
in
{
  options.programs.fish.catppuccin = lib.ctp.mkCatppuccinOpt "fish";

  # xdg is required for this to work
  config = mkIf enable {
    xdg = {
      enable = lib.mkForce true;

      configFile."fish${themePath}".source = "${sources.fish}${themePath}";
    };

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

{ config
, lib
, ...
}:
let
  inherit (lib) ctp mkIf;
  inherit (config.catppuccin) sources;
  cfg = config.programs.fish.catppuccin;
  enable = cfg.enable && config.programs.fish.enable;

  themeName = "Catppuccin ${ctp.mkUpper cfg.flavour}";
  themePath = "/themes/${themeName}.theme";
in
{
  options.programs.fish.catppuccin = lib.ctp.mkCatppuccinOpt "fish";

  config = mkIf enable {
    assertions = [
      (lib.ctp.assertXdgEnabled "fish")
    ];

    xdg.configFile."fish${themePath}".source = "${sources.fish}${themePath}";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

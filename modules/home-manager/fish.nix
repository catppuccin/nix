{ catppuccinLib }:
{
  config,
  options,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fish;
  enable = cfg.enable && config.programs.fish.enable;

  isLatte = cfg.flavor == "latte";
  flavor = if isLatte then "mocha" else cfg.flavor;

  themeName = "Catppuccin ${lib.toSentenceCase flavor}";
in

{
  options.catppuccin.fish = catppuccinLib.mkCatppuccinOption { name = "fish"; };

  config = lib.mkIf enable {
    # if the user has explicitly chosen Latte, that means they probally haven't
    # seen the note that latte is included in every theme, so lets warn them
    warnings = lib.optional (
      isLatte && (options.catppuccin.fish.flavor.highestPrio != (lib.mkOptionDefault { }).priority)
    ) "fish by default uses Latte as the light theme, defaulting to Mocha.";

    xdg.configFile."fish/themes/${themeName}.theme".source = "${sources.fish}/${themeName}.theme";

    programs.fish.shellInit = ''
      fish_config theme choose "${themeName}"
    '';
  };
}

{ config, lib, ... }:
let
  inherit (config.programs.freetube.settings) baseTheme;
  inherit (lib.ctp) mkAccentOpt mkUpper;
  cfg = config.programs.freetube.catppuccin;
  enable = cfg.enable && config.programs.freetube.enable;
in
{
  options.programs.freetube.catppuccin = lib.ctp.mkCatppuccinOpt { name = "freetube"; } // {
    accent = mkAccentOpt "FreeTube";
    # FreeTube supports two accent colors
    secondaryAccent = mkAccentOpt "FreeTube" // {
      # Have the secondary accent default to FreeTube's main accent rather than the global Catppuccin accent
      # This assumes most users would prefer both accent colors to be the same when only overriding the main one
      default = cfg.accent;
    };
  };

  config.programs.freetube.settings = lib.mkIf enable {
    # NOTE: For some reason, baseTheme does not capitalize first letter, but the other settings do
    baseTheme = "catppuccin${mkUpper cfg.flavor}";
    mainColor = mkUpper "${baseTheme}${mkUpper cfg.accent}";
    secColor = mkUpper "${baseTheme}${mkUpper cfg.secondaryAccent}";
  };
}

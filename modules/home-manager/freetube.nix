{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (lib) toSentenceCase;
  inherit (config.programs.freetube.settings) baseTheme;

  cfg = config.catppuccin.freetube;
in

{
  options.catppuccin.freetube =
    catppuccinLib.mkCatppuccinOption {
      name = "freetube";
      accentSupport = true;
    }
    // {
      # FreeTube supports two accent colors
      secondaryAccent = lib.mkOption {
        type = catppuccinLib.types.accent;
        # Have the secondary accent default to FreeTube's main accent rather than the global Catppuccin accent
        # This assumes most users would prefer both accent colors to be the same when only overriding the main one
        default = cfg.accent;
        description = "Secondary accent for freetube";
      };
    };

  config = lib.mkIf cfg.enable {
    programs.freetube.settings = {
      # NOTE: For some reason, baseTheme does not capitalize first letter, but the other settings do
      baseTheme = "catppuccin${toSentenceCase cfg.flavor}";
      mainColor = toSentenceCase "${baseTheme}${toSentenceCase cfg.accent}";
      secColor = toSentenceCase "${baseTheme}${toSentenceCase cfg.secondaryAccent}";
    };
  };
}

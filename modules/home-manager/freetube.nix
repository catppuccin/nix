{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (catppuccinLib) mkUpper;
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

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "programs"
        "freetube"
        "catppuccin"
      ];
      to = "freetube";
      accentSupport = true;
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "freetube"
          "catppuccin"
          "secondaryAccent"
        ]
        [
          "catppuccin"
          "freetube"
          "secondaryAccent"
        ]
      )
    ];

  config = lib.mkIf cfg.enable {
    programs.freetube.settings = {
      # NOTE: For some reason, baseTheme does not capitalize first letter, but the other settings do
      baseTheme = "catppuccin${mkUpper cfg.flavor}";
      mainColor = mkUpper "${baseTheme}${mkUpper cfg.accent}";
      secColor = mkUpper "${baseTheme}${mkUpper cfg.secondaryAccent}";
    };
  };
}

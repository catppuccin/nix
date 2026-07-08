{ catppuccinLib }:
{
  options,
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cursors;

  enable =
    if
      (
        (lib.versionAtLeast catppuccinLib.getModuleRelease "27.05")
        || (options.catppuccin.autoEnable.highestPrio != 1500)
      )
    then
      config.catppuccin.enable && cfg.enable
    else
      cfg.enable;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = lib.types.mergeTypes catppuccinLib.types.accent (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in

{
  options.catppuccin.cursors =
    catppuccinLib.mkCatppuccinOption {
      name = "pointer cursors";
      useGlobalEnable = pkgs.stdenv.hostPlatform.isLinux;
    }
    // {
      accent = lib.mkOption {
        type = cursorAccentType;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for pointer cursors";
      };
    };

  config = lib.mkIf enable {
    home.pointerCursor = {
      name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
      package = sources.cursors."${cfg.flavor}${lib.toSentenceCase cfg.accent}";
    };
  };
}

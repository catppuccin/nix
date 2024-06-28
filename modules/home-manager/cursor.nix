{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.catppuccin.pointerCursor;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = ctp.mergeEnums ctp.types.accentOption (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in
{
  options.catppuccin.pointerCursor =
    ctp.mkCatppuccinOpt {
      name = "pointer cursors";
      enableDefault = config.catppuccin.enable && pkgs.stdenv.hostPlatform.isLinux;
    }
    // {
      accent = ctp.mkBasicOpt "accent" cursorAccentType "cursors";
    };

  config.home.pointerCursor = mkIf cfg.enable {
    name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
    package = pkgs.catppuccin-cursors.${cfg.flavor + ctp.mkUpper cfg.accent};
  };
}

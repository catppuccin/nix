{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cursors;

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

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "catppuccin"
      "pointerCursor"
    ];
    to = "cursors";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
      package = sources.cursors;
    };
  };
}

{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.catppuccin.pointerCursor;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = catppuccinLib.mergeEnums catppuccinLib.types.accent (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in

{
  options.catppuccin.pointerCursor =
    catppuccinLib.mkCatppuccinOption {
      name = "pointer cursors";
      # NOTE: We exclude this as there is no `enable` option in the upstream
      # module to guard it
      useGlobalEnable = false;
    }
    // {
      accent = lib.mkOption {
        type = cursorAccentType;
        default = config.catppuccin.accent;
        description = "Catppuccin accent for pointer cursors";
      };
    };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
      package = pkgs.catppuccin-cursors.${cfg.flavor + catppuccinLib.mkUpper cfg.accent};
    };
  };
}

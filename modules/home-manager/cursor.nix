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
  cursorAccentType = ctp.mergeEnums ctp.types.accent (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in
{
  options.catppuccin.pointerCursor =
    ctp.mkCatppuccinOption {
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

  config.home.pointerCursor = mkIf cfg.enable {
    name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
    package = pkgs.catppuccin-cursors.${cfg.flavor + ctp.mkUpper cfg.accent};
  };
}

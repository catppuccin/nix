{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.cursors;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = catppuccinLib.mergeEnums catppuccinLib.types.accent (
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

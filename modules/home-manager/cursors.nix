{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) ctp mkIf;
  cfg = config.catppuccin.cursors;

  # "dark" and "light" can be used alongside the regular accents
  cursorAccentType = ctp.mergeEnums ctp.types.accentOption (
    lib.types.enum [
      "dark"
      "light"
    ]
  );
in
{
  options.catppuccin.cursors =
    ctp.mkCatppuccinOpt {
      name = "pointer cursors";
      # NOTE: we exclude this from the global `catppuccin.enable` as there is no
      # `enable` option in the upstream module to guard it
      enableDefault = false;
    }
    // {
      accent = ctp.mkBasicOpt "accent" cursorAccentType "cursors";
    };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "catppuccin"
      "pointerCursor"
    ];
    to = "cursors";
    accentSupport = true;
  };

  config.home.pointerCursor = mkIf cfg.enable {
    name = "catppuccin-${cfg.flavor}-${cfg.accent}-cursors";
    package = pkgs.catppuccin-cursors.${cfg.flavor + ctp.mkUpper cfg.accent};
  };
}

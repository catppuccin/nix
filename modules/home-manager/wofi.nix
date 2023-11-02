{ config
, pkgs
, lib
, sources
, ...
}:
let
  inherit (builtins) readFile;

  cfg = config.programs.wofi.catppuccin;
  enable = cfg.enable && config.programs.wofi.enable;
  # The font already hardcoded in the theme
  hardcodedFont = "Inconsolata Nerd Font";
in
{
  options.programs.wofi.catppuccin =
    lib.ctp.mkCatppuccinOpt "wofi"
    // {
      font = lib.mkOption {
        type = lib.types.str;
        default = hardcodedFont;
        description = "Font to use for wofi";
      };
    };

  config.programs.wofi.style = lib.mkIf enable
    (readFile
      (pkgs.runCommand "catppuccin-wofi-theme" { } ''
        cp ${sources.wofi}/src/${cfg.flavour}/style.css $out
        substituteInPlace $out --replace "${hardcodedFont}" "${cfg.font}"
      ''));
}

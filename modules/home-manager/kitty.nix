{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin.kitty;
in
{
  options.catppuccin.kitty = catppuccinLib.mkCatppuccinOption { name = "kitty"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "kitty"
      "catppuccin"
    ];
    to = "kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      themeFile = "Catppuccin-${catppuccinLib.mkUpper cfg.flavor}";
    };
  };
}

{ config, lib, ... }:
let
  inherit (lib) ctp;
  cfg = config.programs.kitty.catppuccin;
  enable = cfg.enable && config.programs.kitty.enable;
in
{
  options.programs.kitty.catppuccin = ctp.mkCatppuccinOpt { name = "kitty"; };

  config = lib.mkIf enable { programs.kitty.themeFile = "Catppuccin-${ctp.mkUpper cfg.flavor}"; };
}

{ config, lib, ... }:
let
  inherit (lib) ctp;
  cfg = config.programs.kitty.catppuccin;
  enable = cfg.enable && config.programs.kitty.enable;
in
{
  options.programs.kitty.catppuccin = ctp.mkCatppuccinOpt "kitty";

  config.programs.kitty = lib.mkIf enable { theme = "Catppuccin-${ctp.mkUpper cfg.flavor}"; };
}

{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.zathura.catppuccin;
  enable = cfg.enable && config.programs.zathura.enable;
in
{
  options.programs.zathura.catppuccin = lib.ctp.mkCatppuccinOption { name = "zathura"; };

  config.programs.zathura.extraConfig = lib.mkIf enable ''
    include ${sources.zathura + "/src/catppuccin-${cfg.flavor}"}
  '';
}

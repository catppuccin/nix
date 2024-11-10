{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.zathura;
  enable = cfg.enable && config.programs.zathura.enable;
in
{
  options.catppuccin.zathura = lib.ctp.mkCatppuccinOpt { name = "zathura"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "zathura"
      "catppuccin"
    ];
    to = "zathura";
  };

  config.programs.zathura.extraConfig = lib.mkIf enable ''
    include ${sources.zathura + "/src/catppuccin-${cfg.flavor}"}
  '';
}

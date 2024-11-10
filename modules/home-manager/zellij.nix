{ config, lib, ... }:
let
  cfg = config.catppuccin.zellij;
  enable = cfg.enable && config.programs.zellij.enable;
  themeName = "catppuccin-${cfg.flavor}";
in
{
  options.catppuccin.zellij = lib.ctp.mkCatppuccinOpt { name = "zellij"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "zellij"
      "catppuccin"
    ];
    to = "zellij";
  };

  config = lib.mkIf enable {
    programs.zellij.settings = {
      theme = themeName;
    };
  };
}

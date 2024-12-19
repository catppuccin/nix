{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.zellij;
  themeName = "catppuccin-${cfg.flavor}";
in

{
  options.catppuccin.zellij = catppuccinLib.mkCatppuccinOption { name = "zellij"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "zellij"
      "catppuccin"
    ];
    to = "zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      settings = {
        theme = themeName;
      };
    };
  };
}

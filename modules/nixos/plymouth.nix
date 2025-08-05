{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.plymouth;
in

{
  options.catppuccin.plymouth = catppuccinLib.mkCatppuccinOption { name = "plymouth"; };

  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      theme = "catppuccin-${cfg.flavor}";
      themePackages = [ config.catppuccin.sources.plymouth ];
    };
  };
}

{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.catppuccin.plymouth;
in
{
  options.catppuccin.plymouth = catppuccinLib.mkCatppuccinOption { name = "plymouth"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "boot"
      "plymouth"
      "catppuccin"
    ];
    to = "plymouth";
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      theme = "catppuccin-${cfg.flavor}";
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = cfg.flavor; }) ];
    };
  };
}

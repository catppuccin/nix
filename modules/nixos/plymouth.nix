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

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
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
      themePackages = [ config.catppuccin.sources.plymouth ];
    };
  };
}

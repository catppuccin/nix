{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.tofi;
in
{
  options.catppuccin.tofi = catppuccinLib.mkCatppuccinOption { name = "tofi"; };

  imports = catppuccinLib.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "tofi"
      "catppuccin"
    ];
    to = "tofi";
  };

  config = lib.mkIf cfg.enable {
    programs.tofi = {
      settings = {
        include = sources.tofi + "/themes/catppuccin-${cfg.flavor}";
      };
    };
  };
}

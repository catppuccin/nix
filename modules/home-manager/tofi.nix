{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.tofi;
  enable = cfg.enable && config.programs.tofi.enable;
in
{
  options.catppuccin.tofi = lib.ctp.mkCatppuccinOpt { name = "tofi"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "tofi"
      "catppuccin"
    ];
    to = "tofi";
  };

  config.programs.tofi = lib.mkIf enable {
    settings.include = sources.tofi + "/themes/catppuccin-${cfg.flavor}";
  };
}

{ config, lib, ... }:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.rio;
  enable = cfg.enable && config.programs.rio.enable;
in
{
  options.catppuccin.rio = ctp.mkCatppuccinOpt { name = "rio"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "rio"
      "catppuccin"
    ];
    to = "rio";
  };

  config = lib.mkIf enable {
    programs.rio.settings = lib.importTOML "${sources.rio}/themes/catppuccin-${cfg.flavor}.toml";
  };
}

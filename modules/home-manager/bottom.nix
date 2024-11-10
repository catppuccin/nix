{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.bottom;
  enable = cfg.enable && config.programs.bottom.enable;
in
{
  options.catppuccin.bottom = lib.ctp.mkCatppuccinOpt { name = "bottom"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "bottom"
      "catppuccin"
    ];
    to = "bottom";
  };

  config = lib.mkIf enable {
    programs.bottom = {
      settings = lib.importTOML "${sources.bottom}/themes/${cfg.flavor}.toml";
    };
  };
}

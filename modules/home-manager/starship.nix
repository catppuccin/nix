{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.starship;
  enable = cfg.enable && config.programs.starship.enable;
in
{
  options.catppuccin.starship = lib.ctp.mkCatppuccinOpt { name = "starship"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "starship"
      "catppuccin"
    ];
    to = "starship";
  };

  config.programs.starship.settings = lib.mkIf enable (
    {
      format = lib.mkDefault "$all";
      palette = "catppuccin_${cfg.flavor}";
    }
    // lib.importTOML "${sources.starship}/themes/${cfg.flavor}.toml"
  );
}

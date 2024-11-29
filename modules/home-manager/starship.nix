{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.starship.catppuccin;
  enable = cfg.enable && config.programs.starship.enable;
in
{
  options.programs.starship.catppuccin = lib.ctp.mkCatppuccinOpt { name = "starship"; };

  config.programs.starship.settings = lib.mkIf enable (
    {
      format = lib.mkDefault "$all";
      palette = "catppuccin_${cfg.flavor}";
    }
    // lib.importTOML "${sources.starship}/${cfg.flavor}.toml"
  );
}

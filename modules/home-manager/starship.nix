{ config
, lib
, ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.starship.catppuccin;
  enable = cfg.enable && config.programs.starship.enable;
in
{
  options.programs.starship.catppuccin =
    lib.ctp.mkCatppuccinOpt "starship";

  config.programs.starship.settings =
    lib.mkIf enable
      ({
        format = lib.mkDefault "$all";
        palette = "catppuccin_${cfg.flavour}";
      }
      // builtins.fromTOML (builtins.readFile "${sources.starship}/palettes/${cfg.flavour}.toml"));
}

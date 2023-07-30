{ config
, lib
, inputs
, ...
}:
let
  inherit (builtins) fromTOML readFile;
  cfg = config.programs.starship.catppuccin;
  enable = cfg.enable && config.programs.starship.enable;
in
{
  options.programs.starship.catppuccin =
    lib.ctp.mkCatppuccinOpt "starship" config;

  config.programs.starship.settings =
    lib.mkIf enable
      ({
        format = lib.mkDefault "$all";
        palette = "catppuccin_${cfg.flavour}";
      }
      // fromTOML (readFile "${inputs.starship}/palettes/${cfg.flavour}.toml"));
}

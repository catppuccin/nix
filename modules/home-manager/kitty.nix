{ config, lib, ... }:
let cfg = config.programs.kitty.catppuccin;
in {
  options.programs.kitty.catppuccin =
    lib.ctp.mkCatppuccinOpt "kitty" config;

  config.programs.kitty = with lib;
    let flavourUpper = ctp.mkUpper cfg.flavour;
    in mkIf cfg.enable { theme = "Catppuccin-${flavourUpper}"; };
}

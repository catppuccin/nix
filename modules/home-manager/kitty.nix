{ config, lib, ... }:
let cfg = config.programs.kitty.catppuccin;
in {
  options.programs.kitty.catppuccin =
    lib.ctp.mkCatppuccinOpt "kitty" config;

  config.programs.kitty = with lib;
    with ctp;
    let flavourUpper = mkUpper cfg.flavour;
    in mkIf cfg.enable { theme = "Catppuccin-${flavourUpper}"; };
}

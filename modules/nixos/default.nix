{ config, pkgs, lib, ... }: let
 extendedLib = import ../lib/mkExtLib.nix lib;
in {
  imports = let
    files = [
    ];
  in
    extendedLib.ctp.mapModules config pkgs extendedLib files;


  options.catppuccin = with extendedLib; {
    flavour = mkOption {
      type = ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

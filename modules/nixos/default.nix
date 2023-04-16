{ config, pkgs, lib, ... }: let
 extendedLib = import ../lib/mkExtLib.nix lib;
in {
  imports = let
    files = [
    ];
  in
    extendedLib.ctp.mapModules config pkgs extendedLib files;


  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

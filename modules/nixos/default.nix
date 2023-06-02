nixpkgs: { config, pkgs, lib, ... }:
let
  extendedLib = import ../lib/mkExtLib.nix nixpkgs.lib;
in
{
  imports =
    let
      files = [
        ./grub.nix
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

{ inputs, ... }@flakeArgs: { lib, pkgs, ... }@systemArgs:
let
  extendedLib = import ../lib/mkExtLib.nix inputs.nixpkgs.lib (systemArgs // flakeArgs);
in
{
  imports =
    let
      files = [
        ./grub.nix
      ];
    in
    extendedLib.ctp.mapModules extendedLib files;


  options.catppuccin = with extendedLib; {
    flavour = mkOption {
      type = ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

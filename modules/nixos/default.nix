{ lib, ... }:

{
  _class = "nixos";

  imports = [
    (lib.modules.importApply ../global.nix { catppuccinModules = import ./all-modules.nix; })
  ];
}

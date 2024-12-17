{ lib, ... }:

{
  imports = [
    (lib.modules.importApply ../global.nix { catppuccinModules = import ./all-modules.nix; })
  ];
}

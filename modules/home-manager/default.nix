{ lib, ... }:

{
  _class = "homeManager";

  imports = [
    (lib.modules.importApply ../global.nix { catppuccinModules = import ./all-modules.nix; })
  ];
}

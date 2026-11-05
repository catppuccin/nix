{ config, lib, ... }:

{
  _class = "homeManager";

  imports = [
    (lib.modules.importApply ../global.nix { catppuccinModules = import ./all-modules.nix; })
  ];

  config = lib.mkIf (config.catppuccin.enable && config.catppuccin.fontPackage != null) {
    home.packages = [ config.catppuccin.fontPackage ];
  };
}

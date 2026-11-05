{ config, lib, ... }:

{
  _class = "darwin";

  imports = [
    (lib.modules.importApply ../global.nix { catppuccinModules = import ./all-modules.nix; })
  ];

  config = lib.mkIf (config.catppuccin.enable && config.catppuccin.fontPackage != null) {
    fonts.packages = [ config.catppuccin.fontPackage ];
  };
}

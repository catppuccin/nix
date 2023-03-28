{ config, pkgs, lib, ... }: {
  imports = [
    ./bat.nix
    ./starship.nix
  ];
  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

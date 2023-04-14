{ config, pkgs, lib, ... }: {
  imports = [
    ./bat.nix
    ./starship.nix
    ./gtk.nix
  ];
  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "latte";
      description = "Global Catppuccin flavour";
    };
    accent = lib.mkOption {
      type = lib.types.enum [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow" ];
      default = "teal";
      description = "Global Catppuccin accent";
    };
  };
}

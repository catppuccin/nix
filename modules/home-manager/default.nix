{ config, pkgs, lib, ... }: let
 extendedLib = import ../lib/mkExtLib.nix lib;
in {
  imports = let
    files = [
      ./alacritty.nix
      ./bat.nix
      ./bottom.nix
      ./btop.nix
      ./kitty.nix
      ./starship.nix
      ./helix.nix
      ./gtk.nix
      ./polybar.nix
      ./tmux.nix
    ];
  in extendedLib.ctp.mapModules config pkgs extendedLib files;

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

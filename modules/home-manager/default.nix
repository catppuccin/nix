nixpkgs: { config, pkgs, lib, ... }:
let
  extendedLib = import ../lib/mkExtLib.nix nixpkgs.lib;
in
{
  imports =
    let
      files = [
        ./alacritty.nix
        ./bat.nix
        ./bottom.nix
        ./btop.nix
        ./kitty.nix
        ./starship.nix
        ./helix.nix
        ./gtk.nix
        ./neovim.nix
        ./polybar.nix
        ./sway.nix
        ./tmux.nix
      ];
    in
    extendedLib.ctp.mapModules config pkgs extendedLib files;

  options.catppuccin = with extendedLib; {
    flavour = mkOption {
      type = ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };
    accent = mkOption {
      type = ctp.types.accentOption;
      default = "teal";
      description = "Global Catppuccin accent";
    };
  };
}

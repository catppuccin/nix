{
  description = "Soothing pastel theme for Nix";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }: {
    nixosModules.catppuccin = import ./modules/nixos nixpkgs;
    homeManagerModules.catppuccin = import ./modules/home-manager nixpkgs;
  };
}

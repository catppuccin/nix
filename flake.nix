{
  description = "Soothing pastel theme for Nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = _: {
    nixosModules.catppuccin = import ./modules/nixos;
    homeManagerModules.catppuccin = import ./modules/home-manager;
  };
}

{
  description = "Soothing pastel theme for Nix";
  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = _: {
    nixosModules.catppuccin = import ./nixos;
    homeManagerModules.catppuccin = import ./home-manager;
  };
}

{
  description = "Soothing pastel theme for Nix";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = _: {
    nixosModules.default = import ./nixos;
    homeManagerModules.default = import ./home-manager;
  };
}

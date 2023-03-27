{
  description = "Soothing pastel theme for Nix";
  inputs = {};
  outputs = { self }: {
    nixosModules.default = import ./nixos;
    homeManagerModules.default = import ./home-manager;
  };
}

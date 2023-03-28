{
  description = "Soothing pastel theme for Nix";
  outputs = { self }: {
    nixosModules.default = import ./nixos;
    homeManagerModules.default = import ./home-manager;
  };
}

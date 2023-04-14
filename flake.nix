{
  description = "Soothing pastel theme for Nix";
  outputs = { self }: {
    nixosModules.default = import ./modules/nixos;
    homeManagerModules.default = import ./modules/home-manager;
  };
}

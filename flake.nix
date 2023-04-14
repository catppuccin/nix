{
  description = "Soothing pastel theme for Nix";
  outputs = { self }: {
    nixosModules.catppuccin = import ./modules/nixos;
    homeManagerModules.catppuccin = import ./modules/home-manager;
  };
}

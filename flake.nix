{
  description = "Soothing pastel theme for Nix";

  outputs = _: {
    homeManagerModules.catppuccin = import ./modules/home-manager;
    nixosModules.catppuccin = import ./modules/nixos;
  };
}

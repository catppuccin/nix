{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:

    let
      inherit (nixpkgs) lib;

      # Systems for public outputs
      systems = lib.systems.flakeExposed;

      # Systems for development related outputs
      # (that evaluate more exotic packages cleanly, unlike some systems above)
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = lib.genAttrs systems;
      forAllDevSystems = lib.genAttrs devSystems;

      mkModule =
        {
          name ? "catppuccin",
          type,
          file,
        }:
        { pkgs, ... }:
        {
          _file = "${self.outPath}/flake.nix#${type}Modules.${name}";

          imports = [ file ];

          catppuccin.sources = lib.mkDefault self.packages.${pkgs.stdenv.hostPlatform.system};
        };
    in

    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          catppuccinPackages = (import ./default.nix { inherit pkgs; }).packages;
        in
        catppuccinPackages
        // {
          default = catppuccinPackages.whiskers;
        }
      );

      devShells = forAllDevSystems (system: {
        default = import ./shell.nix { pkgs = nixpkgs.legacyPackages.${system}; };
      });

      formatter = forAllDevSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      homeManagerModules.catppuccin = mkModule {
        type = "homeManager";
        file = ./modules/home-manager;
      };

      nixosModules.catppuccin = mkModule {
        type = "nixos";
        file = ./modules/nixos;
      };
    };
}

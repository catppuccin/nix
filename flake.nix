{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    /*
      Inputs below this are optional and can be removed

      ```
      {
        inputs.catppuccin = {
          url = "github:catppuccin/nix";
          inputs = {
            nixpkgs-stable.follows = "";
            home-manager.follows = "";
            home-manager-stable.follows = "";
            nuscht-search.follows = "";
            catppuccin-v1_1.follows = "";
            catppuccin-v1_2.follows = "";
          };
        };
      }
      ```
    */

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nuscht-search = {
      url = "github:NuschtOS/search";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Track some of our minor releases to index in our search

    catppuccin-v1_1 = {
      url = "https://flakehub.com/f/catppuccin/nix/1.1.*.tar.gz";
    };

    catppuccin-v1_2 = {
      url = "https://flakehub.com/f/catppuccin/nix/1.2.*.tar.gz";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;

      # Systems for public outputs
      systems = lib.systems.flakeExposed;

      # Systems for development relatedo otuputs
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # flake-utils pollyfill
      forEachSystem =
        systems: fn:
        lib.foldl' (
          acc: system:
          lib.recursiveUpdate acc (
            lib.mapAttrs (lib.const (value: {
              ${system} = value;
            })) (fn system)
          )
        ) { } systems;

      forEachDefaultSystem = forEachSystem systems;
      forEachDevSystem = forEachSystem devSystems;

      # Versions of the modules we want to index in our search
      searchVersions = {
        "v1.1" = inputs.catppuccin-v1_1;
        "v1.2" = inputs.catppuccin-v1_2;
        "rolling" = self;
      };

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

      mergeAttrs = lib.foldl' lib.recursiveUpdate { };
    in

    mergeAttrs [
      # Public outputs
      (forEachDefaultSystem (
        system:

        let
          pkgs = nixpkgs.legacyPackages.${system};
          catppuccinPackages = (import ./default.nix { inherit pkgs; }).packages;
        in

        {
          packages = catppuccinPackages // {
            default = catppuccinPackages.whiskers;
          };
        }
      ))

      {
        homeManagerModules.catppuccin = mkModule {
          type = "homeManager";
          file = ./modules/home-manager;
        };

        nixosModules.catppuccin = mkModule {
          type = "nixos";
          file = ./modules/nixos;
        };
      }

      # Development outputs
      (forEachDevSystem (
        system:

        let
          pkgs = nixpkgs.legacyPackages.${system};
          pkgsStable = inputs.nixpkgs-stable.legacyPackages.${system};
        in

        {
          apps = {
            serve = {
              type = "app";
              program = lib.getExe self.packages.${system}.site.serve;
            };
          };

          checks =

            let
              kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;

              callWith = pkgs: lib.flip pkgs.callPackage;
              callUnstable = callWith pkgs { inherit (inputs) home-manager; };
              callStable = callWith pkgsStable { home-manager = inputs.home-manager-stable; };
            in

            {
              darwin = {
                test-unstable = callUnstable ./tests/darwin.nix;
                test-stable = callStable ./tests/darwin.nix;
              };

              linux = {
                test-unstable = callUnstable ./tests/nixos.nix;
                test-stable = callStable ./tests/nixos.nix;
              };
            }
            .${kernelName} or { };

          devShells.default = import ./shell.nix { inherit pkgs; };

          formatter = pkgs.nixfmt-rfc-style;

          packages = {
            site = pkgs.callPackage ./docs/package.nix {
              inherit inputs searchVersions;
              nuscht-search = inputs.nuscht-search.packages.${system};
            };
          };
        }
      ))
    ];
}

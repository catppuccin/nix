{
  description = "Development Flake for catppuccin/nix";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    # Module versions we test against (aside from NixOS unstable)

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Our option search generator
    nuscht-search = {
      url = "github:NuschtOS/search";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    # Track some of our minor releases to index in said search

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
      catppuccin,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem mkApp;

      mkApp' = drv: mkApp { inherit drv; };

      # Versions of the modules we want to index in our search
      searchVersions = {
        "v1.1" = inputs.catppuccin-v1_1;
        "v1.2" = inputs.catppuccin-v1_2;
        "rolling" = catppuccin;
      };
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsStable = inputs.nixpkgs-stable.legacyPackages.${system};

        kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;

        callWith = pkgs: lib.flip pkgs.callPackage;
        callUnstable = callWith pkgs { inherit (inputs) home-manager; };
        callStable = callWith pkgsStable { home-manager = inputs.home-manager-stable; };
      in

      {
        apps = {
          serve = mkApp' self.packages.${system}.site.serve;
        };

        checks =
          {
            darwin = {
              test-unstable = callUnstable (catppuccin + "/modules/tests/darwin.nix");
              test-stable = callStable (catppuccin + "/modules/tests/darwin.nix");
            };

            linux = {
              test-unstable = callUnstable (catppuccin + "/modules/tests/nixos.nix");
              test-stable = callStable (catppuccin + "/modules/tests/nixos.nix");
            };
          }
          .${kernelName} or { };

        packages = {
          # Used in CI
          all-ports = pkgs.linkFarm "all-ports" (
            lib.foldlAttrs (
              acc: name: pkg:
              if pkg ? "outPath" then
                acc
                // {
                  ${name} = pkg.outPath;
                }
              else
                acc
            ) { } (lib.removeAttrs catppuccin.packages.${system} [ "default" ])
          );

          site = pkgs.callPackage (catppuccin + "/docs/package.nix") {
            inherit inputs searchVersions;
            nuscht-search = inputs.nuscht-search.packages.${system};
          };
        };
      }
    );
}

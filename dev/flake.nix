{
  description = "Development Flake for catppuccin/nix";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    # TODO: Remove when Nix 2.26 is released
    # Pinned for the above feature
    nix = {
      url = "github:NixOS/nix/043df13f724cc084a805372b0455cc6d8684cd5b";

      # NOTE: The primary Nixpkgs is not overridden so we can leverage the Hydra cache
      inputs = {
        nixpkgs-23-11.follows = "";
        nixpkgs-regression.follows = "";
        flake-compat.follows = "";
        flake-parts.follows = "";
        git-hooks-nix.follows = "";
      };
    };

    # Ditto
    # https://github.com/nix-community/nix-eval-jobs/pull/341
    nix-eval-jobs = {
      url = "github:nix-community/nix-eval-jobs/55935b6ea6281d206a40c1f71fffd7b9455b40f9";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # Make sure it uses our Nix
        nix.follows = "nix";

        nix-github-actions.follows = "";
      };
    };

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

      mergeAttrs = lib.foldl' lib.recursiveUpdate { };
      mkApp' = drv: mkApp { inherit drv; };

      # Versions of the modules we want to index in our search
      searchVersions = {
        "v1.1" = inputs.catppuccin-v1_1;
        "v1.2" = inputs.catppuccin-v1_2;
        "rolling" = self;
      };

      # Systems to build for in CI
      ciSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in

    mergeAttrs [
      (eachDefaultSystem (
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
            build-hydra-job = mkApp' (
              pkgs.writeShellApplication {
                name = "build-hydra-job";

                runtimeInputs = [
                  # TODO: Switch back to Nixpkgs' nix-fast-build when Nix >= 2.26 becomes the default
                  self.packages.${system}.nix-fast-build-2_26
                ];

                text = ''
                  usage="Usage: $0 <hydra_job>"

                  hydra_job="''${1:-}"
                  if [[ -z $hydra_job ]]; then
                    echo -n "$usage"
                    exit 1
                  fi

                  args=(
                    "--no-nom"
                    "--skip-cached"
                    "--flake" "${self.outPath}#hydraJobs.$hydra_job.${system}"
                  )

                  nix-fast-build "''${args[@]}"
                '';
              }
            );

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
            site = pkgs.callPackage (catppuccin + "/docs/package.nix") {
              inherit inputs searchVersions;
              nuscht-search = inputs.nuscht-search.packages.${system};
            };

            # TODO: Switch back to Nixpkgs' nix-eval-jobs when Nix 2.26 is released
            nix-fast-build-2_26 = pkgs.nix-fast-build.override {
              inherit (inputs.nix-eval-jobs.packages.${system}) nix-eval-jobs;
            };
          };
        }
      ))

      {
        # Nicely organize some of the outputs we want to build in CI
        hydraJobs = lib.mapAttrs (lib.const (lib.getAttrs ciSystems)) {
          inherit (self) checks;
          # Re-export the base Flake's packages
          inherit (catppuccin) packages;
        };
      }
    ];
}

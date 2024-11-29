{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NOTE: This is only to deduplicate inputs
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nuscht-search = {
      url = "github:NuschtOS/search";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    catppuccin-rolling = {
      url = "github:catppuccin/nix";
    };

    catppuccin-v1_1 = {
      url = "https://flakehub.com/f/catppuccin/nix/1.1.*.tar.gz";
    };

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      self,
      nuscht-search,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      nixpkgsFor = nixpkgs.lib.genAttrs systems (system: {
        unstable = nixpkgs.legacyPackages.${system};
        stable = nixpkgs-stable.legacyPackages.${system};
      });

      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Versions of the modules we want to index in our search
      searchVersions =
        map
          (versionName: {
            inherit versionName;
            catppuccin = inputs."catppuccin-${lib.replaceStrings [ "." ] [ "_" ] versionName}";
          })
          [
            "v1.1"
            "rolling"
          ];
    in

    {
      apps = forAllSystems (system: {
        serve = {
          type = "app";
          program = lib.getExe self.packages.${system}.site.serve;
        };
      });

      checks = forAllSystems (
        system:

        let
          pkgs = nixpkgsFor.${system};

          callUnstable = lib.flip pkgs.unstable.callPackage { inherit home-manager; };
          callStable = lib.flip pkgs.stable.callPackage { home-manager = home-manager-stable; };
        in

        lib.optionalAttrs pkgs.unstable.stdenv.hostPlatform.isDarwin {
          darwin-test-unstable = callUnstable ../tests/darwin.nix;
          darwin-test-stable = callStable ../tests/darwin.nix;
        }
        // lib.optionalAttrs pkgs.unstable.stdenv.hostPlatform.isLinux {
          nixos-test-unstable = callUnstable ../tests/nixos.nix;
          nixos-test-stable = callStable ../tests/nixos.nix;
        }
      );

      formatter = forAllSystems (system: nixpkgsFor.${system}.unstable.nixfmt-rfc-style);

      packages = forAllSystems (
        system:

        let
          pkgs = nixpkgsFor.${system}.unstable;

          mkSite = pkgs.callPackage ../docs/mk-site.nix { };
          mkSearchInstance = pkgs.callPackage ../docs/mk-search.nix {
            inherit (nuscht-search.packages.${system}) mkMultiSearch;
          };

          search-instances = lib.listToAttrs (
            map (
              { catppuccin, versionName }:
              {
                name = "search-${versionName}";
                value = mkSearchInstance { inherit catppuccin versionName; };
              }
            ) searchVersions
          );
        in

        search-instances
        // {
          site = mkSite {
            pname = "catppuccin-nix-site";
            version = self.shortRev or self.dirtyShortRev or "unknown";

            src = ../docs;

            postPatch = "ln -sf ${inputs.catppuccin-rolling + "/CHANGELOG.md"} src/NEWS.md";

            postInstall = lib.concatLines (
              [ "mkdir -p $out/search" ]
              ++ lib.mapAttrsToList (
                name: value: "ln -s ${value.outPath} $out/${lib.replaceStrings [ "-" ] [ "/" ] name}"
              ) search-instances
            );
          };

          add-source =
            pkgs.runCommand "add-source"
              {
                nativeBuildInputs = [ pkgs.patsh ];
                buildInputs = [ pkgs.npins ];
                meta.mainProgram = "add-source";
              }
              ''
                mkdir -p $out/bin

                patsh \
                  --store-dir ${builtins.storeDir} \
                  ${./add-source.sh} $out/bin/add-source

                chmod 755 $out/bin/add-source
              '';

          default = self.packages.${system}.site;
        }
      );
    };
}

{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
    }:
    let
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
    in
    {
      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system}.unstable;
          inherit (pkgs) lib;
        in
        {
          serve = {
            type = "app";
            program = lib.getExe self.packages.${system}.site.serve;
          };
        }
      );

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
          inherit (pkgs.unstable) lib;

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
          inherit (pkgs) lib;

          version = self.shortRev or self.dirtyShortRev or "unknown";
          mkOptionDoc = pkgs.callPackage ../docs/options-doc.nix { };
          mkSite = pkgs.callPackage ../docs/mk-site.nix { };
          packages' = self.packages.${system};
        in
        {
          nixos-doc = mkOptionDoc {
            inherit version;
            moduleRoot = ../modules/nixos;
          };

          home-manager-doc = mkOptionDoc {
            inherit version;
            moduleRoot = ../modules/home-manager;
          };

          site = mkSite rec {
            pname = "catppuccin-nix-website";
            inherit version;

            src = lib.fileset.toSource {
              root = ../.;
              fileset = lib.fileset.unions [
                ../CHANGELOG.md
                ../docs/src
                ../docs/book.toml
                ../docs/theme
              ];
            };
            sourceRoot = "${src.name}/docs";

            nixosDoc = packages'.nixos-doc;
            homeManagerDoc = packages'.home-manager-doc;
          };

          default = packages'.site;
        }
      );
    };
}

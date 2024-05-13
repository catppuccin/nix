{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/release-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    mdbook = {
      url = "github:catppuccin/mdbook";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, home-manager-stable, mdbook }:
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

      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn nixpkgsFor.${system}.unstable);
    in
    {
      apps = forAllSystems ({ lib, pkgs, system, ... }: {
        add-source = {
          type = "app";
          program = lib.getExe (
            pkgs.runCommand "add-source"
              {
                nativeBuildInputs = [ pkgs.makeWrapper ];
                meta.mainProgram = "add-source";
              } ''
              mkdir -p $out/bin
              install -Dm755 ${./add_source.sh} $out/bin/add-source
              wrapProgram $out/bin/add-source \
                --prefix PATH : ${ lib.makeBinPath [ pkgs.npins ]}
            ''
          );
        };

        serve = {
          type = "app";
          program = lib.getExe self.packages.${system}.site.serve;
        };
      });

      checks = forAllSystems ({ lib, pkgs, system, ... }: lib.optionalAttrs pkgs.stdenv.isLinux {
        module-test-unstable = pkgs.callPackage ../test.nix { inherit home-manager; };
        module-test-stable = nixpkgsFor.${system}.stable.callPackage ../test.nix {
          home-manager = home-manager-stable;
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      packages = forAllSystems ({ lib, pkgs, system, ... }:
        let
          version = self.shortRev or self.dirtyShortRev or "unknown";
          mkOptionDoc = pkgs.callPackage ../docs/options-doc.nix { };
          mkSite = pkgs.callPackage ../docs/mk-site.nix { inherit (mdbook.packages.${system}) mdbook-catppuccin; };
          packages' = self.packages.${system};
        in
        {
          nixos-doc = mkOptionDoc {
            inherit version;
            modules = [ ../modules/nixos ];
          };

          home-manager-doc = mkOptionDoc {
            inherit version;
            modules = [ ../modules/home-manager ];
          };

          site = mkSite {
            pname = "catppuccin-nix-website";
            inherit version;

            src = lib.fileset.toSource {
              root = ../docs;
              fileset = lib.fileset.unions [
                ../docs/src
                ../docs/book.toml
              ];
            };

            nixosDoc = packages'.nixos-doc;
            homeManagerDoc = packages'.home-manager-doc;
          };

          default = packages'.site;
        });
    };
}

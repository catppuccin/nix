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
          };
        };
      }
      ```
    */

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
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;

      # flake-utils pollyfill
      forEachSystem =
        fn:
        lib.foldl' (
          acc: system:
          lib.recursiveUpdate acc (
            lib.mapAttrs (lib.const (value: {
              ${system} = value;
            })) (fn system)
          )
        ) { } systems;

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

    lib.mergeAttrsList [
      (forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pkgsStable = nixpkgs-stable.legacyPackages.${system};
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
              inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

              callWith = pkgs: lib.flip pkgs.callPackage;
              callUnstable = callWith pkgs { inherit home-manager; };
              callStable = callWith pkgsStable { home-manager = home-manager-stable; };
            in
            lib.optionalAttrs isDarwin {
              darwin-test-unstable = callUnstable ./tests/darwin.nix;
              darwin-test-stable = callStable ./tests/darwin.nix;
            }
            // lib.optionalAttrs isLinux {
              nixos-test-unstable = callUnstable ./tests/nixos.nix;
              nixos-test-stable = callStable ./tests/nixos.nix;
            };

          devShells.default = import ./shell.nix { inherit pkgs; };

          formatter = pkgs.nixfmt-rfc-style;

          packages =
            let
              packages' = self.packages.${system};

              catppuccinPackages = (import ./default.nix { inherit pkgs; }).packages;

              docVersion = self.shortRev or self.dirtyShortRev or "unknown";
              mkOptionDoc = pkgs.callPackage ./docs/options-doc.nix { };
              mkSite = pkgs.callPackage ./docs/mk-site.nix { };
            in
            catppuccinPackages
            // {
              default = catppuccinPackages.whiskers;

              nixos-doc = mkOptionDoc {
                version = docVersion;
                moduleRoot = ./modules/nixos;
              };

              home-manager-doc = mkOptionDoc {
                version = docVersion;
                moduleRoot = ./modules/home-manager;
              };

              site = mkSite rec {
                pname = "catppuccin-nix-website";
                version = docVersion;

                src = lib.fileset.toSource {
                  root = ./.;
                  fileset = lib.fileset.unions [
                    ./CHANGELOG.md
                    ./docs/src
                    ./docs/book.toml
                    ./docs/theme
                  ];
                };

                sourceRoot = "${src.name}/docs";

                nixosDoc = packages'.nixos-doc;
                homeManagerDoc = packages'.home-manager-doc;
              };
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
    ];
}

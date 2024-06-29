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

      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn nixpkgsFor.${system}.unstable);
    in
    {
      apps = forAllSystems (
        {
          lib,
          pkgs,
          system,
          ...
        }:
        {
          add-source = {
            type = "app";
            program = lib.getExe (
              pkgs.runCommand "add-source"
                {
                  nativeBuildInputs = [ pkgs.makeWrapper ];
                  meta.mainProgram = "add-source";
                }
                ''
                  mkdir -p $out/bin
                  install -Dm755 ${./add_source.sh} $out/bin/add-source
                  wrapProgram $out/bin/add-source \
                    --prefix PATH : ${lib.makeBinPath [ pkgs.npins ]}
                ''
            );
          };

          serve = {
            type = "app";
            program = lib.getExe self.packages.${system}.site.serve;
          };
        }
      );

      checks = forAllSystems (
        {
          lib,
          pkgs,
          system,
          ...
        }:
        import ../tests {
          inherit lib home-manager home-manager-stable;
          nixpkgs = pkgs;
          nixpkgs-stable = nixpkgsFor.${system}.stable;
        }
      );

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (
        {
          lib,
          pkgs,
          system,
          ...
        }:
        let
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

          site = mkSite {
            pname = "catppuccin-nix-website";
            inherit version;

            src = lib.fileset.toSource {
              root = ../docs;
              fileset = lib.fileset.unions [
                ../docs/src
                ../docs/book.toml
                ../docs/theme
              ];
            };

            nixosDoc = packages'.nixos-doc;
            homeManagerDoc = packages'.home-manager-doc;
          };

          default = packages'.site;
        }
      );
    };
}

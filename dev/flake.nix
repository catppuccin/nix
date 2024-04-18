{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn nixpkgs.legacyPackages.${system});
    in
    {
      apps = forAllSystems ({ lib, pkgs, ... }: {
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
      });

      checks = forAllSystems ({ lib, pkgs, ... }: lib.optionalAttrs pkgs.stdenv.isLinux {
        module-vm-test = pkgs.callPackage ../test.nix { inherit home-manager; };
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      packages = forAllSystems (pkgs:
        let
          version = self.shortRev or self.dirtyShortRev or "unknown";
          mkOptionDoc = args: (pkgs.callPackage ./option-doc.nix { }) (args // { inherit version; });
        in
        {
          nixos-doc = mkOptionDoc {
            modules = [ ../modules/nixos ];
          };

          home-manager-doc = mkOptionDoc {
            modules = [ ../modules/home-manager ];
          };

          default = self.packages.${pkgs.system}.home-manager-doc;
        });
    };
}

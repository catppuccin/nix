{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      inherit (nixpkgs) lib;

      forAllSystems = fn: lib.genAttrs systems (s: fn nixpkgs.legacyPackages.${s});

      sources = pkgs:
        let
          s =
            import ./_sources/generated.nix { inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools; };
        in
        builtins.mapAttrs (_: p: p.src) s;
    in
    {
      checks = forAllSystems (pkgs: lib.optionalAttrs pkgs.stdenv.isLinux {
        module-vm-test = pkgs.nixosTest (import ./test.nix { inherit self inputs; });
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      homeManagerModules.catppuccin = import ./modules/home-manager { inherit inputs sources; };

      nixosModules.catppuccin = import ./modules/nixos { inherit inputs sources; };

      packages = forAllSystems (pkgs:
        let
          eval = module: lib.evalModules {
            modules = [
              module
              {
                _module = {
                  check = false;
                  args.lib = import ./modules/lib/mkExtLib.nix lib;
                };
              }
            ];
          };

          mkDoc = name: module:
            let
              doc = pkgs.nixosOptionsDoc {
                options = lib.filterAttrs (n: _: n != "_module") (eval module).options;
                documentType = "none";
                revision = builtins.substring 0 7 self.rev or "dirty";
              };
            in
            pkgs.runCommand "${name}-module-doc.md" { } ''
              cat ${doc.optionsCommonMark} > $out
            '';
        in
        {
          nixos-doc = mkDoc "nixos" self.nixosModules.catppuccin;
          home-manager-doc = mkDoc "home-manager" self.homeManagerModules.catppuccin;

          default = self.packages.${pkgs.system}.home-manager-doc;
        });
    };
}

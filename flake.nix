{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      inherit (nixpkgs) lib;

      forAllSystems = fn: lib.genAttrs systems (s: fn nixpkgsFor.${s});
      nixpkgsFor = lib.genAttrs systems (system: import nixpkgs { inherit system; });

      nixosLib = import (nixpkgs + "/nixos/lib") { };
      runTestFor = system: test: nixosLib.runTest {
        imports = [ test ];

        hostPkgs = nixpkgsFor.${system};

        _module.args = {
          catppuccin = self;
          inherit nixpkgs home-manager;
        };
      };

      sources = pkgs:
        let
          s =
            import ./_sources/generated.nix { inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools; };
        in
        builtins.mapAttrs (_: p: p.src) s;
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      homeManagerModules.catppuccin = import ./modules/home-manager { inherit inputs sources; };

      nixosModules.catppuccin = import ./modules/nixos { inherit inputs sources; };

      packages = forAllSystems (pkgs:
        let
          mkEval = module: lib.evalModules {
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

          mkDoc = name: options:
            let
              doc = pkgs.nixosOptionsDoc {
                options = lib.filterAttrs (n: _: n != "_module") options;
                documentType = "none";
                revision = if self ? rev then builtins.substring 0 7 self.rev else "dirty";
              };
            in
            pkgs.runCommand "${name}-module-doc.md" { } ''
              cat ${doc.optionsCommonMark} > $out
            '';

          hmEval = mkEval self.homeManagerModules.catppuccin;
          nixosEval = mkEval self.nixosModules.catppuccin;
        in
        rec {
          nixos-doc = mkDoc "nixos" nixosEval.options;
          home-manager-doc = mkDoc "home-manager" hmEval.options;
          default = home-manager-doc;
        });

      tests.x86_64-linux.modules = runTestFor "x86_64-linux" ./test.nix;
    };
}

{
  description = "Soothing pastel theme for Nix";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }:
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
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      homeManagerModules.catppuccin = import ./modules/home-manager nixpkgs;

      nixosModules.catppuccin = import ./modules/nixos nixpkgs;

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
    };
}

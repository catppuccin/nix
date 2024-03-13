{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/divnix/call-flake/issues/4
    call-flake.url = "github:divnix/call-flake/a9bc85f5bd939734655327a824b4e7ceb4ccaba9";
  };

  outputs = { self, nixpkgs, call-flake, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      inherit (nixpkgs) lib;

      forAllSystems = fn: lib.genAttrs systems (s: fn nixpkgs.legacyPackages.${s});
      ctp = call-flake ../.;
    in
    {
      checks = forAllSystems (pkgs: lib.optionalAttrs pkgs.stdenv.isLinux {
        module-vm-test = pkgs.nixosTest (import ../test.nix { inherit ctp inputs; });
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

      packages = forAllSystems (pkgs:
        let
          eval = module: lib.evalModules {
            modules = [
              module
              {
                _module.check = false;
              }
            ];
          };

          mkDoc = name: module:
            let
              doc = pkgs.nixosOptionsDoc {
                options = lib.filterAttrs (n: _: n != "_module") (eval module).options;
                documentType = "none";
                revision = builtins.substring 0 8 self.rev or "dirty";
              };
            in
            pkgs.runCommand "${name}-module-doc.md" { } ''
              cat ${doc.optionsCommonMark} > $out
            '';
        in
        {
          nixos-doc = mkDoc "nixos" ctp.nixosModules.catppuccin;
          home-manager-doc = mkDoc "home-manager" ctp.homeManagerModules.catppuccin;

          default = self.packages.${pkgs.system}.home-manager-doc;
        });
    };
}

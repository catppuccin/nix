{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, self }:

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

      mergeAttrs = lib.foldl' lib.recursiveUpdate { };
    in

    mergeAttrs [
      # Public outputs
      (forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages =
            let
              catppuccinPackages = (import ./default.nix { inherit pkgs; }).packages;
            in
            catppuccinPackages // { default = pkgs.emptyFile; };
        }
      ))

      {
        homeManagerModules.catppuccin = import ./modules/home-manager;
        nixosModules.catppuccin = import ./modules/nixos;
      }
    ];
}

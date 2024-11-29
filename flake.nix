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
            catppuccinPackages // { default = catppuccinPackages.whiskers; };
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

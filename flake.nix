{
  description = "Soothing pastel theme for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:

    let
      inherit (nixpkgs) lib;

      # Systems for public outputs
      systems = lib.systems.flakeExposed;

      # Systems for development related outputs
      # (that evaluate more exotic packages cleanly, unlike some systems above)
      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = lib.genAttrs systems;
      forAllDevSystems = lib.genAttrs devSystems;

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

    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          catppuccinPackages = (import ./default.nix { inherit pkgs; }).packages;
        in
        catppuccinPackages
        // {
          default = catppuccinPackages.whiskers;
        }
      );

      devShells = forAllDevSystems (
        system:

        let
          pkgs = nixpkgs.legacyPackages.${system};
        in

        lib.genAttrs [ "default" "ci" ] (
          name:
          import ./shell.nix {
            inherit pkgs;
            minimal = name == "ci";
          }
        )
      );

      formatter = forAllDevSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.treefmt.withConfig {
          runtimeInputs = with pkgs; [
            keep-sorted
            nixfmt-rfc-style
          ];

          settings = {
            on-unmatched = "info";
            tree-root-file = "flake.nix";

            formatter = {
              keep-sorted = {
                command = "keep-sorted";
                includes = [ "*" ];
              };
              nixfmt = {
                command = "nixfmt";
                includes = [ "*.nix" ];
              };
            };
          };
        }
      );

      # TODO: Remove before 2.0 is stable
      homeManagerModules = lib.mapAttrs (
        name:
        lib.warn "Obsolete Flake attribute `catppuccin.homeManagerModules.${name}' is used. It was renamed to `catppuccin.homeModules.${name}`'."
      ) self.homeModules;

      homeModules = {
        default = self.homeModules.catppuccin;
        catppuccin = mkModule {
          type = "homeManager";
          file = ./modules/home-manager;
        };
      };

      nixosModules = {
        default = self.nixosModules.catppuccin;
        catppuccin = mkModule {
          type = "nixos";
          file = ./modules/nixos;
        };
      };
    };
}

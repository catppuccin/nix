{
  description = "Development Flake for catppuccin/nix";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    # Module versions we test against (aside from NixOS unstable)

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      nixpkgs,
      catppuccin,
      ...
    }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsStable = inputs.nixpkgs-stable.legacyPackages.${system};

        kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;

        callWith = pkgs: lib.flip pkgs.callPackage;
        callUnstable = callWith pkgs { inherit (inputs) home-manager; };
        callStable = callWith pkgsStable { home-manager = inputs.home-manager-stable; };
      in

      {
        checks =
          {
            darwin = {
              test-unstable = callUnstable (catppuccin + "/modules/tests/darwin.nix");
              test-stable = callStable (catppuccin + "/modules/tests/darwin.nix");
            };

            linux = {
              test-unstable = callUnstable (catppuccin + "/modules/tests/nixos.nix");
              test-stable = callStable (catppuccin + "/modules/tests/nixos.nix");
            };
          }
          .${kernelName} or { };

        packages = {
          # Used in CI
          all-ports = pkgs.linkFarm "all-ports" (
            lib.foldlAttrs (
              acc: name: pkg:
              if pkg ? "outPath" then
                acc
                // {
                  ${name} = pkg.outPath;
                }
              else
                acc
            ) { } (lib.removeAttrs catppuccin.packages.${system} [ "default" ])
          );
        };
      }
    );
}

{
  description = "Development Flake for catppuccin/nix";

  inputs = {
    # WARN: This handling of `path:` is a Nix 2.26 feature. The Flake won't work correctly on versions prior to it
    # https://github.com/NixOS/nix/pull/10089
    catppuccin.url = "path:../.";
    nixpkgs.follows = "catppuccin/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, catppuccin, ... }@inputs:

    let
      inherit (nixpkgs) lib;
      inherit (inputs.flake-utils.lib) eachDefaultSystem;
    in

    eachDefaultSystem (
      system:

      let
        pkgs = nixpkgs.legacyPackages.${system};

        kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;
        callTest = lib.flip pkgs.callPackage { inherit (inputs) home-manager; };
      in

      {
        checks = catppuccin.packages.${system} or { } // {
          module-test = callTest (
            catppuccin + "/modules/tests/${if (kernelName == "linux") then "nixos" else kernelName}.nix"
          );
        };
      }
    );
}

{
  pkgs ? import <nixpkgs> {
    inherit system;
    config = { };
    overlays = [ ];
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,
}:

let
  catppuccinPackages =
    let
      generated = lib.foldlAttrs (
        acc: port:
        {
          rev,
          hash,
          lastModified,
        }:
        lib.recursiveUpdate acc {
          # Save our sources for each port
          sources.${port} = catppuccinPackages.fetchCatppuccinPort { inherit port rev hash; };

          # And create a default package for them
          "${port}" = catppuccinPackages.buildCatppuccinPort { inherit port lastModified; };
        }
      ) { } (lib.importJSON ./pkgs/sources.json);

      collected = lib.packagesFromDirectoryRecursive {
        callPackage = lib.callPackageWith (pkgs // catppuccinPackages);
        directory = ./pkgs;
      };
    in
    generated
    // collected
    /*
      TODO(@getchoo): Remove this with 25.05!!!

      Pin foot to an older version in Nixpkgs < 25.11. See:
      - https://github.com/catppuccin/nix/issues/636
      - https://github.com/catppuccin/nix/pull/622
    */
    // lib.optionalAttrs (!(lib.versionAtLeast lib.version "25.11pre")) {
      foot = generated.foot.overrideAttrs (oldAttrs: {
        src = oldAttrs.src.override {
          rev = "962ff1a5b6387bc5419e9788a773a080eea5f1e1";
          hash = "sha256-eVH3BY2fZe0/OjqucM/IZthV8PMsM9XeIijOg8cNE1Y=";
        };

        lastModified = "2024-09-24";
      });
    };
in

{
  # Filter out derivations not available on/meant for the current system
  packages = lib.filterAttrs (lib.const (
    deriv:
    let
      # Only export packages available on the current system, *unless* they are being cross compiled
      availableOnHost = lib.meta.availableOn pkgs.stdenv.hostPlatform deriv;
      # `nix flake check` doesn't like broken packages
      broken = deriv.meta.broken or false;
      isCross = deriv.stdenv.buildPlatform != deriv.stdenv.targetPlatform;
      # Make sure we don't remove our functions
      isFunction = lib.isFunction deriv;
    in
    isFunction || (!broken) && availableOnHost || isCross
  )) catppuccinPackages;

  shell = import ./shell.nix { inherit pkgs; };
}

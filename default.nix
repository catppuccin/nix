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
    generated // collected;
in

{
  # Filter out derivations not available on/meant for the current system
  packages = lib.filterAttrs (
    name: deriv:
    if name == "sources" || lib.isFunction deriv then
      false
    else
      let
        # Only export packages available on the current system, *unless* they are being cross compiled
        availableOnHost = lib.meta.availableOn pkgs.stdenv.hostPlatform deriv;
        # `nix flake check` doesn't like broken packages
        broken = deriv.meta.broken or false;
        isCross = deriv.stdenv.buildPlatform != deriv.stdenv.targetPlatform;
      in
      (!broken) && availableOnHost || isCross
  ) catppuccinPackages;

  shell = import ./shell.nix { inherit pkgs; };
}

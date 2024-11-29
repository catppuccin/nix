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
  catppuccinPackages = lib.packagesFromDirectoryRecursive {
    callPackage = lib.callPackageWith (pkgs // catppuccinPackages);
    directory = ./pkgs;
  };

  # Filter out derivations not available on/meant for the current system
  filtered = lib.filterAttrs (lib.const (
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
in

{
  packages = filtered;
}

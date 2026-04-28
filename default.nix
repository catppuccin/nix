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
  catppuccinPackages = pkgs.lib.makeScope pkgs.newScope (
    self:
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
          sources.${port} = self.fetchCatppuccinPort {
            inherit
              port
              rev
              hash
              lastModified
              ;
          };

          # And create a default package for them
          "${port}" = self.buildCatppuccinPort { inherit port; };
        }
      ) { } (lib.importJSON ./pkgs/sources.json);

      collected = lib.packagesFromDirectoryRecursive {
        inherit (self) callPackage;
        directory = ./pkgs;
      };
    in
    generated // collected
  );
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

# this imports all files in a directory (besides default.nix)
# with our modified arguments
{ lib, pkgs, ... }@args:
dir:
let
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
lib.pipe dir [
  builtins.readDir
  builtins.attrNames

  (builtins.filter (
    n: !(builtins.elem n [ "default.nix" ])
  ))

  (map (
    f: _: import "${dir}/${f}" (args // {
      sources = builtins.mapAttrs (_: p: p.src) generated;
      lib = lib.extend (_: _: { ctp = import ./. args; });
    })
  ))
]

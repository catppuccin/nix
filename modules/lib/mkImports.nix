# this imports all files in a directory (besides default.nix)
# with our modified arguments
{ lib, pkgs, ... }@args:
dir:
let
  # instead of letting `evalModules` pass arguments to each file
  # in our list, we import them directly
  applyImports = file: _: import "${dir}/${file}" (args // {
    lib = lib.extend (final: _: {
      ctp = import ./. (args // { lib = final; });
    });
  });
in
lib.pipe dir [
  builtins.readDir
  builtins.attrNames
  (lib.remove "default.nix")
  (map applyImports)
]

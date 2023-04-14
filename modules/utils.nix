{ lib, ... }: {
  # path -> [path]
  # return an array of all nix files in a given
  # directory (except default.nix)
  importModules = dir: let
    inherit (builtins) map;

    # filter through default.nix, directories,
    # and non-nix files
    modules = let
      inherit (builtins) attrNames;

      dirs = let
        inherit (builtins) readDir;
        inherit (lib) filterAttrs;
        use = n: v: lib.hasSuffix ".nix" n && n != "default.nix" && v == "regular";
      in
        filterAttrs use (readDir dir);
    in
      attrNames dirs;
  in
    map (module: "${dir}/${module}") modules;
}

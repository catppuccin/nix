{
  buildCatppuccinPort,
  build-stylus-settings,
  userstylesConfig ? { },
}:
let
  userstylesOptionsFile = builtins.toFile "catppuccin-userstyles-options" (
    builtins.toJSON userstylesConfig
  );
in
buildCatppuccinPort {
  port = "userstyles";

  nativeBuildInputs = [
    build-stylus-settings
  ];

  buildPhase = ''
    mkdir -p $out/share ./deno_cache
    DENO_DIR=$PWD/deno_cache build-stylus-settings "$src/styles" "${userstylesOptionsFile}"
    cp storage.js $out/share/
  '';
}

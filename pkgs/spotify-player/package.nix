{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "spotify-player";

  installTargets = [
    "theme.toml"
    "README.md"
  ];
}

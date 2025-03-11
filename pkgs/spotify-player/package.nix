{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "spotify-player";

  installTargets = [
    "theme.toml"
    "README.md"
  ];
}

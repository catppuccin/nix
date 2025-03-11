{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "palette";

  installTargets = [
    "README.md"
    "palette.json"
  ];
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "palette";

  installTargets = [
    "README.md"
    "palette.json"
  ];
}

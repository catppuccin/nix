{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "palette";

  dontCatppuccinBuild = true;

  installTargets = [
    "README.md"
    "palette.json"
  ];
}

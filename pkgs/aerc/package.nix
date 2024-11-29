{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "aerc";

  installTargets = [ "dist/" ];
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "aerc";

  installTargets = [ "dist/" ];
}

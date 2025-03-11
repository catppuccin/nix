{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "micro";

  installTargets = [ "src" ];
}

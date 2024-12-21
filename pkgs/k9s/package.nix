{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "k9s";

  installTargets = [ "dist" ];
}

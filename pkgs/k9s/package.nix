{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "k9s";

  installTargets = [ "dist" ];
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "zathura";

  installTargets = [ "src" ];
}

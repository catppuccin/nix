{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "firefox";

  dontBuild = true;

  installTargets = [ "releases/old" ];
}

{ buildCatppuccinPort, whiskers }:

buildCatppuccinPort {
  port = "zed";

  nativeBuildInputs = [ whiskers ];

  buildPhase = ''
    runHook preBuild
    whiskers zed.tera
    runHook postBuild
  '';

  installTargets = [ "themes" ];
}

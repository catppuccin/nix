{ buildCatppuccinPort, whiskers }:

buildCatppuccinPort {
  pname = "zed";

  nativeBuildInputs = [ whiskers ];

  buildPhase = ''
    runHook preBuild
    whiskers zed.tera
    runHook postBuild
  '';

  installTargets = [ "themes" ];
}

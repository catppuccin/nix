{
  buildCatppuccinPort,
  fetchYarnDeps,
  sources,
  yarnConfigHook,
  yarnBuildHook,
  nodejs,
}:
buildCatppuccinPort {
  port = "firefox";

  patches = [
    ./write-themes-to-json.patch
  ];

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = sources.firefox + /yarn.lock;
    hash = "sha256-EWx1/kujC6HBSJr6d4sTlFwANbZqBQ3FHetHcbMtiVU=";
  };

  yarnBuildScript = "generate";

  installPhase = ''
    mkdir -p $out
    cp themes.json $out
  '';

  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    nodejs
  ];
}

{
  fetchPnpmDeps,
  pnpm_10,
  pnpmConfigHook,
  stdenv,
  nodejs_24,
  fetchCatppuccinPort,
}:

let
  nodejs = nodejs_24;
  pnpm = pnpm_10.override { inherit nodejs; };
in

stdenv.mkDerivation (finalAttrs: rec {
  inherit pnpm;
  pname = "catppuccin-obsidian";
  version = "3.0.0";

  src = fetchCatppuccinPort {
    port = "obsidian";
    rev = "55aa9c9036a9df864593fdaedb2a227d3823fb06";
    hash = "sha256-uB0a2nSZkHHf65xBYXyNh50vaAiqdEpKQVf3eXnCVlE=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
  ];

  __structuredAttrs = true;
  strictDeps = true;

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src pnpm;
    fetcherVersion = 3;
    hash = "sha256-WgthXRObQ3zojRAYZ4AYKTCJZuUprq9AwtaEg8wApIQ=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./dist/catppuccin.css $out/theme.css

    runHook postInstall
  '';
})
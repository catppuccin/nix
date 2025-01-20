{ buildCatppuccinPort, fetchzip }:

buildCatppuccinPort (finalAttrs: {
  pname = "gitea";
  version = "0.4.1";

  src = fetchzip {
    url = "https://github.com/catppuccin/gitea/releases/download/v${finalAttrs.version}/catppuccin-gitea.tar.gz";
    sha256 = "sha256-14XqO1ZhhPS7VDBSzqW55kh6n5cFZGZmvRCtMEh8JPI=";
    stripRoot = false;
  };

  dontCatppuccinInstall = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mv * $out

    runHook postInstall
  '';
})

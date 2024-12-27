{
  lib,
  fetchCatppuccinPort,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "whiskers";
  version = "2.5.1";

  src = fetchCatppuccinPort {
    port = "whiskers";
    rev = "refs/tags/v${version}";
    hash = "sha256-OLEXy9MCrPQu1KWICsYhe/ayVqxkYIFwyJoJhgiNDz4=";
  };

  cargoHash = "sha256-ol8qdC+Cf7vG/X/Q7q9UZmxMWL8i49AI8fQLQt5Vw0A=";

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Soothing port creation tool for the high-spirited!";
    homepage = "https://catppuccin.com";
    license = lib.licenses.mit;
  };
}

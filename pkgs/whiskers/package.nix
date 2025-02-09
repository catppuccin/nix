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

  useFetchCargoVendor = true;
  cargoHash = "sha256-CVg7kcOTRa8KfDwiJHQhTPQfK6g3jOMa4h/BCUo3ehw=";

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Soothing port creation tool for the high-spirited!";
    homepage = "https://catppuccin.com";
    license = lib.licenses.mit;
  };
}

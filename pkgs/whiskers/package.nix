{
  lib,
  fetchCatppuccinPort,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "whiskers";
  version = "2.9.0";

  src = fetchCatppuccinPort {
    port = "whiskers";
    tag = "v${finalAttrs.version}";
    hash = "sha256-KU2cHBtz9rdfhulINRaQm+YZ7n8OBULrSHSSxmoitnk=";
  };

  cargoHash = "sha256-40IPDdxKTWYxsCfsECsXDGwfxXiTEIelxIGAFv3xlU4=";

  __structuredAttrs = true;

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Soothing port creation tool for the high-spirited!";
    homepage = "https://catppuccin.com";
    license = lib.licenses.mit;
    mainProgram = "whiskers";
    maintainers = with lib.maintainers; [
      getchoo
      isabelroses
    ];
  };
})

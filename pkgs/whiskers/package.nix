{
  lib,
  fetchCatppuccinPort,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "catppuccin-whiskers";
  version = "2.10.0";

  src = fetchCatppuccinPort {
    port = "whiskers";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ca8wKCaE6S/Rqw2I1lDbNAlN/D1wHUgXzv7JIxgeOvk=";
  };

  cargoHash = "sha256-IxkNPl6GkNVb/71O7wHo9Ld9E42Rx0l3SJdb1J4NoOI=";

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

{
  lib,
  stdenv,
  buildPackages,
  fetchCatppuccinPort,
  installShellFiles,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "catwalk";
  version = "1.3.2";

  src = fetchCatppuccinPort {
    port = "catwalk";
    rev = "refs/tags/v${version}";
    hash = "sha256-Yj9xTQJ0eu3Ymi2R9fgYwBJO0V+4bN4MOxXCJGQ8NjU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-stO8ejSC4UeEeMZZLIJ8Wabn7A6ZrWQlU5cZDSm2AVc=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall =
    let
      catwalk = stdenv.hostPlatform.emulator buildPackages + " $out/bin/catwalk";
    in
    lib.optionalString (stdenv.hostPlatform.emulatorAvailable buildPackages) ''
      installShellCompletion --cmd catwalk \
        --bash <(${catwalk} completion bash) \
        --fish <(${catwalk} completion fish) \
        --zsh <(${catwalk} completion zsh)
    '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Soothing pastel previews for the high-spirited!";
    homepage = "https://catppuccin.com";
    license = lib.licenses.mit;
  };
}

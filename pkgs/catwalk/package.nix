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

  cargoHash = "sha256-05tF3dqrKYJHs1iYyh3F0lsK+OCSIbK1J1PtLmP0jng=";

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

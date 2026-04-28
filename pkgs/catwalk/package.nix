{
  lib,
  stdenv,
  fetchCatppuccinPort,
  installShellFiles,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "catwalk";
  version = "1.3.2";

  src = fetchCatppuccinPort {
    port = "catwalk";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Yj9xTQJ0eu3Ymi2R9fgYwBJO0V+4bN4MOxXCJGQ8NjU=";
  };

  cargoHash = "sha256-stO8ejSC4UeEeMZZLIJ8Wabn7A6ZrWQlU5cZDSm2AVc=";

  nativeBuildInputs = [ installShellFiles ];

  __structuredAttrs = true;

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd catwalk \
      --bash <("$out/bin/catwalk" completion bash) \
      --zsh <("$out/bin/catwalk" completion zsh) \
      --fish <("$out/bin/catwalk" completion fish)
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Soothing pastel previews for the high-spirited!";
    homepage = "https://catppuccin.com";
    license = lib.licenses.mit;
    mainProgram = "catwalk";
    maintainers = with lib.maintainers; [
      getchoo
      isabelroses
    ];
  };
})

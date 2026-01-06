{
  lib,
  vscode-utils,
  fetchCatppuccinPort,
  nodejs,
  pnpm,
  pnpmConfigHook,
  fetchPnpmDeps,

  catppuccinOptions ? { },
}:

vscode-utils.buildVscodeExtension (finalAttrs: {
  pname = "catppuccin-vscode";
  name = finalAttrs.pname;
  version = "3.18.0";

  src = fetchCatppuccinPort {
    port = "vscode";
    rev = "refs/tags/@catppuccin/vscode-v${finalAttrs.version}";
    hash = "sha256-vi+QNploStQFrXSc+izcycKtpkrRsq2mJWrKsHP3D5g=";
  };

  vscodeExtPublisher = "catppuccin";
  vscodeExtName = "vscode";
  vscodeExtUniqueId = "catppuccin.vscode";

  sourceRoot = null;

  pnpmWorkspaces = [ "catppuccin-vsc" ];
  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs)
      pname
      version
      src
      pnpmWorkspaces
      ;
    fetcherVersion = 3;
    hash = "sha256-sPJhXj13O16kcaJ8LtJaGOtFxdXBl23wmCV4hcEhz4I=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
  ];

  env = lib.optionalAttrs (catppuccinOptions != { }) {
    CATPPUCCIN_OPTIONS = builtins.toJSON catppuccinOptions;
  };

  buildPhase = ''
    runHook preBuild

    pnpm --filter catppuccin-vsc core:build --no-regenerate

    cd packages/catppuccin-vsc
    node dist/hooks/generateThemes.cjs
    touch ./themes/.flag

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/$installPrefix"
    cp -rL ../../LICENSE ../../README.md package.json icon.png dist/ themes/ "$out/$installPrefix/"

    runHook postInstall
  '';
})

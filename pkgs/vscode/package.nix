{
  lib,
  vscode-utils,
  fetchCatppuccinPort,
  nodejs_24,
  pnpm_10,
  pnpmConfigHook,
  fetchPnpmDeps,

  catppuccinOptions ? { },
}:
let
  nodejs = nodejs_24;
  pnpm = pnpm_10.override { inherit nodejs; };
in
vscode-utils.buildVscodeExtension (finalAttrs: {
  pname = "catppuccin-vscode";
  version = "3.19.0";

  src = fetchCatppuccinPort {
    port = "vscode";
    tag = "@catppuccin/vscode-v${finalAttrs.version}";
    hash = "sha256-HUXRGK10A3YIU6ksTfzOzQvM5J699lJikndlYUgrkRA=";
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
    inherit pnpm;
    fetcherVersion = 3;
    hash = "sha256-DE0mHkBlV0RkrEmtIXnzKaiXOK8vgcCx3z7b49zzBhc=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
  ];

  __structuredAttrs = true;
  strictDeps = true;

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

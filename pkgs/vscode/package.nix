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
    fetcherVersion = 3;
    hash = "sha256-a1er5btH6aYRnKgpyW1UU8fgsuZZO72+/JkYSMaYKSg=";
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

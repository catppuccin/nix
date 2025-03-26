{
  vscode-utils,
  sources,
  nodejs_22,
  pnpm,

  accentColor ? null,
  accent ? "mauve",
  boldKeywords ? true,
  italicComments ? true,
  italicKeywords ? true,
  extraBordersEnabled ? false,
  workbenchMode ? "default",
  bracketMode ? "rainbow",
  colorOverrides ? { },
  customUIColors ? { },
}:

let

  pname = "catppuccin-vscode";
  version = builtins.substring 0 7 src.rev;
  src = sources.vscode;

  pnpmWorkspaces = [ "catppuccin-vsc" ];

  extention = vscode-utils.buildVscodeExtension {
    name = pname;
    inherit
      pname
      version
      src
      ;
    vscodeExtPublisher = "catppuccin";
    vscodeExtName = "vscode";
    vscodeExtUniqueId = "catppuccin.vscode";

    inherit pnpmWorkspaces;
    pnpmDeps = pnpm.fetchDeps {
      inherit
        pname
        version
        src
        pnpmWorkspaces
        ;
      hash = "sha256-W3Ztsy7M4ub0Se2o3ZOe/EMWeXXC+D9Mph0t/UYFTXY=";
    };

    nativeBuildInputs = [
      nodejs_22
      (pnpm.override { nodejs = nodejs_22; }).configHook
    ];

    env.CATPPUCCIN_OPTIONS = builtins.toJSON {
      inherit
        accentColor
        accent
        boldKeywords
        italicComments
        italicKeywords
        extraBordersEnabled
        workbenchMode
        bracketMode
        colorOverrides
        customUIColors
        ;
    };

    buildPhase = ''
      runHook preBuild

      pnpm --filter catppuccin-vsc core:build

      cd packages/catppuccin-vsc
      node dist/hooks/generateThemes.cjs
      touch ./themes/.flag

      runHook postBuild
    '';
  };

in

extention.overrideAttrs (_: {
  sourceRoot = null;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/$installPrefix"
    cp -rL ../../LICENSE ../../README.md package.json icon.png dist/ themes/ "$out/$installPrefix/"

    runHook postInstall
  '';
})

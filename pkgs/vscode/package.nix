{
  lib,
  vscode-utils,
  fetchCatppuccinPort,
  nodejs_22,
  pnpm_10,

  catppuccinOptions ? { },
}:

let

  nodejs = nodejs_22;
  pnpm = pnpm_10.override { inherit nodejs; };

in

vscode-utils.buildVscodeExtension (finalAttrs: {
  pname = "catppuccin-vscode";
  name = finalAttrs.pname;
  version = "3.17.0";

  src = fetchCatppuccinPort {
    port = "vscode";
    rev = "refs/tags/@catppuccin/vscode-v${finalAttrs.version}";
    hash = "sha256-TG6vZjPddZ2vTH4S81CNBI9axKS+HFwyx6GFUDUEC3U=";
  };

  vscodeExtPublisher = "catppuccin";
  vscodeExtName = "vscode";
  vscodeExtUniqueId = "catppuccin.vscode";

  sourceRoot = null;

  pnpmWorkspaces = [ "catppuccin-vsc" ];
  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs)
      pname
      version
      src
      pnpmWorkspaces
      ;
    hash = "sha256-ksxzTirYEzgaQOJ+43K6SUAD/UA1b3Mtyc3HDGtMXeM=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
  ];

  env = lib.optionalAttrs (catppuccinOptions != { }) {
    CATPPUCCIN_OPTIONS = builtins.toJSON catppuccinOptions;
  };

  buildPhase = ''
    runHook preBuild

    pnpm --filter catppuccin-vsc core:build

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

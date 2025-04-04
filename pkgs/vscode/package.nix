{
  lib,
  vscode-utils,
  fetchCatppuccinPort,
  nodejs_22,
  pnpm_10,

  catppuccinOptions ? { },
}:

let

  pname = "catppuccin-vscode";
  version = "3.17.0";

  src = fetchCatppuccinPort {
    port = "vscode";
    rev = "refs/tags/@catppuccin/vscode-v${version}";
    hash = "sha256-TG6vZjPddZ2vTH4S81CNBI9axKS+HFwyx6GFUDUEC3U=";
  };

  nodejs = nodejs_22;
  pnpm = pnpm_10.override { inherit nodejs; };

  pnpmWorkspaces = [ "catppuccin-vsc" ];

  extension = vscode-utils.buildVscodeExtension {
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
  };

in

# TODO: Remove once https://github.com/NixOS/nixpkgs/pull/393486 is widely available
# (Probably 2-4 weeks after this is committed)
extension.overrideAttrs (_: {
  sourceRoot = null;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/$installPrefix"
    cp -rL ../../LICENSE ../../README.md package.json icon.png dist/ themes/ "$out/$installPrefix/"

    runHook postInstall
  '';
})

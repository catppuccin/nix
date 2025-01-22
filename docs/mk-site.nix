{
  lib,
  stdenvNoCC,
  mdbook,
  python3,
  writeShellApplication,
}:

args:

stdenvNoCC.mkDerivation (
  finalAttrs:
  args
  // {
    nativeBuildInputs = args.nativeBuildInputs or [ ] ++ [ mdbook ];

    dontConfigure = true;
    doCheck = false;

    buildPhase = ''
      runHook preBuild
      mdbook build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mv book $out
      runHook postInstall
    '';

    passthru = lib.recursiveUpdate (args.passthru or { }) {
      serve = writeShellApplication {
        name = "serve";

        runtimeInputs = [ python3 ];

        text = ''
          python -m http.server --bind 127.0.0.1 --directory ${finalAttrs.finalPackage}
        '';
      };
    };
  }
)

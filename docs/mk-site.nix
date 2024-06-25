{
  stdenvNoCC,
  writeShellApplication,
  mdbook,
  python3,
}:
{ nixosDoc, homeManagerDoc, ... }@args:
stdenvNoCC.mkDerivation (
  finalAttrs:
  args
  // {
    nativeBuildInputs = [ mdbook ];

    dontPatch = true;
    dontConfigure = true;
    doCheck = false;

    buildPhase = ''
      runHook preBuild

      ln -s ${nixosDoc} src/options/nixos-options.md
      ln -s ${homeManagerDoc} src/options/home-manager-options.md
      mdbook build

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mv book $out

      runHook postInstall
    '';

    passthru = {
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

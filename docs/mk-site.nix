{ lib
, stdenvNoCC
, writeShellApplication
, mdbook
, mdbook-catppuccin
, simple-http-server
}: { nixosDoc
   , homeManagerDoc
   , ...
   }@args:
stdenvNoCC.mkDerivation (finalAttrs: args // {
  nativeBuildInputs = [
    mdbook
    mdbook-catppuccin
  ];

  dontPatch = true;
  doCheck = false;

  configurePhase = ''
    runHook preConfigure

    mdbook-catppuccin install

    runHook postConfigure
  '';

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

      runtimeInputs = [ simple-http-server ];

      text = ''
        simple-http-server --index --ip 127.0.0.1 ${finalAttrs.finalPackage}
      '';
    };
  };
})

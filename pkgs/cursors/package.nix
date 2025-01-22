{
  lib,
  buildCatppuccinPort,
  hyprcursor,
  inkscape,
  just,
  python3,
  whiskers,
  xcur2png,
  xorg,
  zip,
}:

buildCatppuccinPort (finalAttrs: {
  pname = "cursors";

  postPatch = "patchShebangs scripts/ build";

  nativeBuildInputs = [
    (python3.withPackages (p: [ p.pyside6 ]))
    hyprcursor
    inkscape
    just
    whiskers
    xcur2png
    xorg.xcursorgen
    zip
  ];

  buildPhase = ''
    runHook preBuild

    just all

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    mv dist $out/share/icons

    runHook postInstall
  '';

  meta = {
    description = "Catppuccin cursor theme based on Volantes";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
})

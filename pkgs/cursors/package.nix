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
  flavors ? [ ],
  accents ? [ ],
}:

buildCatppuccinPort (finalAttrs: {
  port = "cursors";

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

  buildPhase =
    let
      numFlavors = lib.length flavors;
      numAccents = lib.length accents;
      accentString' = lib.concatStringsSep " " accents;
      accentString = if numAccents == 0 then "" else "'${accentString'}'";
      buildFlavor = flavor: "just build ${flavor} ${accentString}";
      buildCmd =
        if numFlavors == 0 then
          "just all"
        else
          lib.concatStringsSep "\n" (builtins.map buildFlavor flavors);
    in
    ''
      runHook preBuild

      ${buildCmd}

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

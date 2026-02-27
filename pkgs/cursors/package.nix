{
  lib,
  buildCatppuccinPort,
  hyprcursor,
  inkscape,
  just,
  python3,
  whiskers,
  xcur2png,
  xcursorgen,
  zip,
}:
let
  dimensions = {
    flavor = [
      "frappe"
      "latte"
      "macchiato"
      "mocha"
    ];
    accent = [
      "Blue"
      "Dark"
      "Flamingo"
      "Green"
      "Lavender"
      "Light"
      "Maroon"
      "Mauve"
      "Peach"
      "Pink"
      "Red"
      "Rosewater"
      "Sapphire"
      "Sky"
      "Teal"
      "Yellow"
    ];
  };

  variantName = { flavor, accent }: flavor + accent;
  variants = lib.mapCartesianProduct variantName dimensions;
in
buildCatppuccinPort (finalAttrs: {
  port = "cursors";

  postPatch = "patchShebangs scripts/ build";

  # dummy "out" output to prevent breakage
  outputs = variants ++ [ "out" ];
  outputsToInstall = [ ];

  nativeBuildInputs = [
    (python3.withPackages (p: [ p.pyside6 ]))
    hyprcursor
    inkscape
    just
    whiskers
    xcur2png
    xcursorgen
    zip
  ];

  buildPhase = ''
    runHook preBuild

    just all

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    for output in $(getAllOutputNames); do
      if [ "$output" != "out" ]; then
        local outputDir="''${!output}"
        local iconsDir="$outputDir"/share/icons

        mkdir -p "$iconsDir"

        # Convert to kebab case with the first letter of each word capitalized
        local variant=$(sed 's/\([A-Z]\)/-\1/g' <<< "$output")
        local variant=''${variant,,}

        mv "dist/catppuccin-$variant-cursors" "$iconsDir"
      fi
    done

    # Needed to prevent breakage
    mkdir -p "$out"

    runHook postInstall
  '';

  meta = {
    description = "Catppuccin cursor theme based on Volantes";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
})

{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "rofi";

  buildPhase = ''
    runHook preBuild

    # remove the @import line that is included in the file by default
    sed -i '1,2d' catppuccin-default.rasi

    runHook postBuild
  '';

  installTargets = [
    "themes"
    "catppuccin-default.rasi"
  ];
}

{
  buildCatppuccinPort,
  lib,
  enableRounded ? false,
}:

buildCatppuccinPort {
  port = "fcitx5";

  dontCatppuccinInstall = true;

  buildPhase = ''
    runHook preBuild

    ${lib.optionalString enableRounded ''
      patchShebangs ./enable-rounded.sh
      ./enable-rounded.sh
    ''}

    runHook postBuild
  '';

  postInstall = ''
    mkdir -p $out/share/fcitx5
    mv src/ $out/share/fcitx5/themes/
  '';
}

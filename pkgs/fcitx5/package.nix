{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "fcitx5";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out/share/fcitx5
    mv src/ $out/share/fcitx5/themes/
  '';
}

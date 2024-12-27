{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "grub";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out/share/grub
    mv src $out/share/grub/themes
  '';
}

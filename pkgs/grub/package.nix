{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "grub";

  dontCatppuccinBuild = true;
  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out/share/grub
    mv src $out/share/grub/themes
  '';
}

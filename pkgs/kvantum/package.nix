{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  port = "kvantum";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out/share
    mv themes $out/share/Kvantum/
  '';

  meta = {
    platforms = lib.platforms.linux;
  };
})

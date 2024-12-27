{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  pname = "kvantum";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out/share
    mv themes $out/share/Kvantum/
  '';

  meta = {
    platforms = lib.platforms.linux;
  };
})

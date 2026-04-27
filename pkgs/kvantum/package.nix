{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  port = "kvantum";

  dontCatppuccinInstall = true;

  whiskersTemplates = [
    "templates/svg.tera"
    "templates/kvantum.tera"
  ];

  postInstall = ''
    mkdir -p $out/share
    mv themes $out/share/Kvantum/
  '';

  meta = {
    platforms = lib.platforms.linux;
  };
})

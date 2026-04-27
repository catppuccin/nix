{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  port = "plymouth";

  dontCatppuccinInstall = true;

  whiskersTemplates = [
    "bullet.tera"
    "capslock.tera"
    "entry.tera"
    "keyboard.tera"
    "lock.tera"
    "plymouth.tera"
    "preview.tera"
    "throbber.tera"
  ];

  postPatch = ''
    substituteInPlace plymouth.tera \
      --replace-fail '/usr' '${placeholder "out"}'
  '';

  postInstall = ''
    mkdir -p $out/share/plymouth
    mv themes/ $out/share/plymouth/themes/
  '';

  meta = {
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})

{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  port = "plymouth";

  dontCatppuccinInstall = true;

  postPatch = ''
    substituteInPlace themes/**/*.plymouth \
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

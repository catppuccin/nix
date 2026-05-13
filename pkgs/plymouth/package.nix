{
  lib,
  buildCatppuccinPort,
}:

buildCatppuccinPort (finalAttrs: {
  port = "plymouth";

  dontCatppuccinBuild = true;

  postPatch = ''
    substituteInPlace themes/**/*.plymouth \
      --replace-fail '/usr' '${placeholder "out"}'
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth
    mv themes/ $out/share/plymouth/themes/

    runHook postInstall
  '';

  meta = {
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})

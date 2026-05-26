{ buildCatppuccinPort, fetchCatppuccinPort }:

buildCatppuccinPort (finalAttrs: {
  port = "hyprlock";

  dontCatppuccinBuild = true;
  dontCatppuccinInstall = true;

  # Make sure we aren't sourcing possibly non-existent files
  # or overriding our own settings
  postPatch = ''
    sed -i '1,4d' hyprlock.conf
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mv hyprlock.conf $out/
    cp ${finalAttrs.passthru.hyprland}/themes/* $out/

    runHook postInstall
  '';

  passthru.hyprland = fetchCatppuccinPort {
    port = "hyprland";
    tag = "v1.3";
    hash = "sha256-jkk021LLjCLpWOaInzO4Klg6UOR4Sh5IcKdUxIn7Dis=";
  };
})

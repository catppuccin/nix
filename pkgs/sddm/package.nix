{
  lib,
  buildCatppuccinPort,
  bash,
  just,
  whiskers,
  kdePackages,
  background ? null,
  font ? "Noto Sans",
  fontSize ? "9",
  loginBackground ? false,
  userIcon ? false,
  clockEnabled ? true,
}:

buildCatppuccinPort (finalAttrs: {
  port = "sddm";

  postPatch = ''
    substituteInPlace justfile \
      --replace-fail '#!/usr/bin/env bash' '#!${lib.getExe bash}' \

    substituteInPlace src/theme.conf \
      --replace-fail 'Font="Noto Sans"' 'Font="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${toString fontSize}'
  ''
  + lib.optionalString (background != null) ''
    substituteInPlace src/theme.conf \
      --replace-fail 'Background="backgrounds/wall.png"' 'Background="${background}"'
  ''
  + lib.optionalString (background == null) ''
    substituteInPlace src/theme.conf \
      --replace-fail 'CustomBackground="true"' 'CustomBackground="false"'
  ''
  + lib.optionalString loginBackground ''
    substituteInPlace src/theme.conf \
      --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'
  ''
  + lib.optionalString userIcon ''
    substituteInPlace src/theme.conf \
      --replace-fail 'UserIcon="false"' 'UserIcon="true"'
  ''
  + lib.optionalString (!clockEnabled) ''
    substituteInPlace src/theme.conf \
      --replace-fail 'ClockEnabled="true"' 'ClockEnabled="false"'
  '';

  nativeBuildInputs = [
    just
    whiskers
  ];

  propagatedBuildInputs = [
    kdePackages.qtsvg
  ];

  dontCatppuccinInstall = true;

  dontWrapQtApps = true;

  buildPhase = ''
    runHook preBuild
    just build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sddm
    mv themes $out/share/sddm/

    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
  '';

  meta = {
    platforms = lib.platforms.linux;
  };
})

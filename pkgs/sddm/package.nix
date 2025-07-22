{
  lib,
  buildCatppuccinPort,
  just,
  kdePackages,
  background ? null,
  font ? "Noto Sans",
  fontSize ? "9",
  loginBackground ? false,
  userIcon ? false,
  accentColor ? null,
}:

buildCatppuccinPort (finalAttrs: {
  port = "sddm";

  postPatch = ''
    substituteInPlace pertheme/*.conf \
      --replace-fail 'Font="Noto Sans"' 'Font="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${toString fontSize}'
  ''
  + lib.optionalString (background != null) ''
    substituteInPlace pertheme/*.conf \
      --replace-fail 'Background="backgrounds/wall.jpg"' 'Background="${background}"' \
      --replace-fail 'CustomBackground="false"' 'CustomBackground="true"'
  ''
  + lib.optionalString loginBackground ''
    substituteInPlace pertheme/*.conf \
      --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'
  ''
  + lib.optionalString userIcon ''
    substituteInPlace pertheme/*.conf \
      --replace-fail 'UserIcon="false"' 'UserIcon="true"'
  ''
  + lib.optionalString (accentColor != null) ''
    sed -i "s/^AccentColor="[^']*"/AccentColor="${accentColor}"/" pertheme/*.conf
  '';

  nativeBuildInputs = [
    just
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
    mv dist $out/share/sddm/themes

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

{
  lib,
  buildCatppuccinPort,
  fetchFromGitHub,
  git,
  gtk3,
  python3,
  sassc,
  accents ? [ "mauve" ],
  allAccents ? true,
  flavor ? "frappe",
  size ? "standard",
  tweaks ? [ ],
}:

buildCatppuccinPort (finalAttrs: {
  pname = "gtk";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "gtk";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-8KyZtZqVVz5UKuGdLrUsR2djD3nsJDliHMtvFtUVim8=";
  };

  postPatch = ''
    rmdir sources/colloid
    cp -r ${finalAttrs.finalPackage.colloid} sources/colloid
    chmod -R +w sources/colloid
  '';

  nativeBuildInputs = [
    (python3.withPackages (p: [ p.catppuccin ]))
    git # `git apply` is used for patches
    gtk3
    sassc
  ];

  dontConfigure = true;
  dontCatppuccinInstall = true;

  buildFlags =
    [
      flavor
      "--dest"
      "dist"
    ]
    ++ lib.optional allAccents "--all-accents"
    ++ lib.optionals (accents != [ ]) [
      "--accent"
      (toString accents)
    ]
    ++ lib.optionals (size != [ ]) [
      "--size"
      size
    ]
    ++ lib.optionals (tweaks != [ ]) [
      "--tweaks"
      (toString tweaks)
    ];

  postBuild = ''
    python3 build.py $buildFlags
  '';

  postInstall = ''
    mkdir -p $out/share
    mv dist $out/share/themes
  '';

  passthru = {
    colloid = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Colloid-gtk-theme";
      rev = "1a13048ea1bd4a6cb9b293b537afd16bf267e773";
      hash = "sha256-zYEoOCNI74Dahlbi5fniuL5PYXcGM4cVM1T2vnnGrcc=";
    };
  };

  meta = {
    description = "Soothing pastel theme for GTK";
    license = lib.licenses.gpl3Plus;
  };
})

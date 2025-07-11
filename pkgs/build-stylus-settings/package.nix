{
  lib,
  buildNpmPackage,
  fetchurl,
}:
let
  stylusSectionsUtil = fetchurl {
    url = "https://raw.githubusercontent.com/openstyles/stylus/8fe35a4b90d85fb911bd7aa1deab4e4733c31150/src/js/sections-util.js";
    hash = "sha256-OH4WStQLx2BI3MqvzmoDKsdFYW5/wp8Yc9faM/VzlQI=";
  };

  usercssMetaTypes = fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/userstyles/714b153c7022c362a37ab8530286a87e4484a828/scripts/types/usercss-meta.d.ts";
    hash = "sha256-e/gazaMzr0WcarsE/NqCVT/iCG9CoB0lnZiOr1l19Jk=";
  };
in
buildNpmPackage (finalAttrs: {
  pname = "build-stylus-settings";
  version = "0.2.0";

  src = lib.cleanSource ./src;

  prePatch = ''
    cp ${stylusSectionsUtil} ./scripts/sections-util.js
    cp ${usercssMetaTypes} ./scripts/usercss-meta.d.ts
  '';

  patches = [
    ./usercss-meta-stringify-type.patch
  ];

  npmDepsHash = "sha256-YshVeiUTXueFW8yDA/kOfYR0jUW+f6+5bdzinbGvo+g=";

  meta = {
    description = "Stylus storage.js file generator, compatible with Catppuccin Userstyles";
    license = lib.licenses.mit;
    mainProgram = "build-stylus-settings";
    maintainers = with lib.maintainers; [
      getchoo
      isabelroses
    ];
  };
})

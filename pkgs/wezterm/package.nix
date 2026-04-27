{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "wezterm";

  dontCatppuccinBuild = true;

  installTargets = [
    "dist"
    "plugin"
  ];
}

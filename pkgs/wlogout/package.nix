{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "wlogout";

  installTargets = [
    "themes"
    "icons"
  ];
}

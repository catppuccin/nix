{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "rofi";

  installTargets = [
    "themes"
    "catppuccin-default.rasi"
  ];
}

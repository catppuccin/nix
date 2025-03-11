{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "rofi";

  installTargets = [
    "themes"
    "catppuccin-default.rasi"
  ];
}

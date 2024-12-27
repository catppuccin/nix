{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "rofi";

  installTargets = [ "basic/.local/share/rofi/themes" ];
}

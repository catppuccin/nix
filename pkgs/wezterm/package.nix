{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "wezterm";

  installTargets = [ "dist" "plugin" ];
}

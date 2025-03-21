{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "wezterm";

  installTargets = [ "dist" "plugin" ];
}

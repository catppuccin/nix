{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "hyprlock";

  # Make sure we aren't sourcing possibly non-existent files
  # or overriding our own settings
  postPatch = ''
    sed -i '1,4d' hyprlock.conf
  '';

  installTargets = [ "hyprlock.conf" ];
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "lazygit";

  installTargets = [ "themes-mergable" ];
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "limine";

  dontCatppuccinInstall = true;

  postInstall = ''
    mv themes $out
  '';
}

{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "alacritty";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out
    mv *.toml $out/
  '';
}

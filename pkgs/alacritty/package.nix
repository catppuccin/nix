{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "alacritty";

  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out
    mv *.toml $out/
  '';
}

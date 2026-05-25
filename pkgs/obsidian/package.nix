{ buildCatppuccinPort }:
buildCatppuccinPort {
  port = "obsidian";

  dontCatppuccinBuild = true;
  dontCatppuccinInstall = true;

  postInstall = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./theme.css $out/theme.css
  '';
}

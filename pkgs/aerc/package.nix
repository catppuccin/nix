{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "aerc";

  whiskersTemplates = [ "theme.tera" ];
  installTargets = [ "dist/" ];
}

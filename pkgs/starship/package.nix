{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "starship";

  whiskersTemplates = [ "templates/starship.tera" ];
}

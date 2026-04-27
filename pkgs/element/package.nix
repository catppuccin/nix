{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "element";

  whiskersTemplates = [
    "templates/element.tera"
    "templates/config.tera"
  ];
}

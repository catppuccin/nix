{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "sway";

  whiskersTemplates = [ "i3.tera" ];
}

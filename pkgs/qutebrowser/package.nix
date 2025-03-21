{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "qutebrowser";

  installTargets = [ "setup.py" "__init__.py" ];
}

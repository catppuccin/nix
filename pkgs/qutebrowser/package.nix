{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "qutebrowser";

  installTargets = [ "setup.py" "__init__.py" ];
}

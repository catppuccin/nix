{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "qutebrowser";

  dontCatppuccinBuild = true;

  installTargets = [
    "setup.py"
    "__init__.py"
  ];
}

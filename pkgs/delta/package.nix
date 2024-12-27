{ buildCatppuccinPort }:

buildCatppuccinPort {
  pname = "delta";

  installTargets = [
    "catppuccin.gitconfig"
    "README.md"
  ];
}

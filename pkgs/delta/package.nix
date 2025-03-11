{ buildCatppuccinPort }:

buildCatppuccinPort {
  port = "delta";

  installTargets = [
    "catppuccin.gitconfig"
    "README.md"
  ];
}

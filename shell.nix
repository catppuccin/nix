{
  pkgs ? import <nixpkgs> {
    config = { };
    overlays = [ ];
  },
}:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    nodejs_22
    corepack

    nrr
    typescript-language-server
  ];
}

{
  pkgs ? import <nixpkgs> {
    inherit system;
    config = { };
    overlays = [ ];
  },
  system ? builtins.currentSystem,
}:

pkgs.mkShellNoCC {
  packages = [
    # GHA lints
    pkgs.actionlint

    # Nix tools
    pkgs.deadnix
    pkgs.nixfmt-rfc-style
    pkgs.nil
    pkgs.statix

    # Python tools
    pkgs.pyright
    pkgs.ruff
    pkgs.ruff-lsp
  ];

  shellHook = ''
    echo "Welcome to the catppuccin/nix repository! Thanks for contributing and have a wonderful day 🐈"
  '';
}

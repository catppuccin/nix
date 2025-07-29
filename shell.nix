{
  pkgs ? import <nixpkgs> {
    inherit system;
    config = { };
    overlays = [ ];
  },
  system ? builtins.currentSystem,
}:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    # Nix tools
    deadnix
    nixfmt-rfc-style
    nil
    statix

    # GHA lints
    actionlint

    # Python tools for paws.py
    pyright
    ruff

    # Node tooling for Astro/Starlight
    nodejs-slim_22
    corepack

    nrr

    astro-language-server
    typescript-language-server

    # Shell lints
    shellcheck
  ];

  shellHook = ''
    echo "Welcome to the catppuccin/nix repository! Thanks for contributing and have a wonderful day 🐈"
  '';
}

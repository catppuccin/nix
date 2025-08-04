{
  pkgs ? import <nixpkgs> {
    inherit system;
    config = { };
    overlays = [ ];
  },
  system ? builtins.currentSystem,
  minimal ? false,
}:

pkgs.mkShellNoCC {
  packages =
    with pkgs;
    [
      /*
        WARN(@getchoo): KEEP A SAFE NIX PINNED!!

        We end up relying on some features exclusive to Nix, like relative path inputs
        https://git.lix.systems/lix-project/lix/issues/641

        We also run into inconsistent evaluation with "distributions" of Nix
        and their features - like DetNix and Lazy Trees

        Basically: Nix is the only one that evaluates our development Flake correctly. Yay.
      */
      nixVersions.nix_2_28

      # Node tooling for Astro/Starlight
      nodejs-slim_22
      corepack
      nrr
    ]
    ++ lib.optionals (!minimal) [
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

      # More node tooling for Astro/Starlight
      astro-language-server
      typescript-language-server

      # Shell lints
      shellcheck
    ];

  shellHook = ''
    echo "Welcome to the catppuccin/nix repository! Thanks for contributing and have a wonderful day 🐈"
  '';
}

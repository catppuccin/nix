{
  lib,
  nixpkgs,
  nixpkgs-stable,
  home-manager,
  home-manager-stable,
}:
lib.optionalAttrs nixpkgs.stdenv.isLinux {
  nixos-test-unstable = nixpkgs.callPackage ./nixos.nix { inherit home-manager; };
  nixos-test-stable = nixpkgs-stable.callPackage ./nixos.nix { home-manager = home-manager-stable; };
}
// lib.optionalAttrs nixpkgs.stdenv.isDarwin {
  darwin-test-unstable = nixpkgs.callPackage ./darwin.nix { inherit home-manager; };
  darwin-test-stable = nixpkgs-stable.callPackage ./darwin.nix {
    home-manager = home-manager-stable;
  };
}
// {
  from-ini = assert import ./from-ini.nix lib; nixpkgs.hello;
}

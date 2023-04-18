{ config, pkgs, lib, ... }:
let
  cfg = config.boot.loader.grub.catppuccin;

  theme = with pkgs;
    let
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "grub";
        rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
        sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
      };
    in runCommand "catppuccin-grub-theme" { } ''
      mkdir -p "$out"
      cp -r ${src}/src/catppuccin-${cfg.flavour}-grub-theme/* "$out"/
    '';
in {
  options.boot.loader.grub.catppuccin =
    lib.ctp.mkCatppuccinOpt "grub" config;

  config.boot.loader.grub = with lib; mkIf cfg.enable {
    font = "${theme}/font.pf2";
    splashImage = "${theme}/background.png";
    inherit theme;
  };
}

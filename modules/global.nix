{ catppuccinModules }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  catppuccinLib = import ./lib { inherit config lib pkgs; };

  minimumVersion = "25.11";
  isMinimumVersion = lib.versionAtLeast catppuccinLib.getModuleRelease minimumVersion;
  # Use this to toggle between a deprecation warning for a release and a full assertion
  warn = true;
in

{
  imports = catppuccinLib.applyToModules catppuccinModules;

  options.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin globally";

    flavor = lib.mkOption {
      type = catppuccinLib.types.flavor;
      default = "mocha";
      description = "Global Catppuccin flavor";
    };

    accent = lib.mkOption {
      type = catppuccinLib.types.accent;
      default = "mauve";
      description = "Global Catppuccin accent";
    };

    sources =
      let
        defaultSources = (import ../default.nix { inherit pkgs; }).packages;
      in
      lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = defaultSources;
        defaultText = "{ ... }";
        # HACK!
        # without this, overriding one source will delete all others. -@getchoo
        apply = lib.recursiveUpdate defaultSources;
        description = "Port sources used across all options";
      };

    cache.enable = lib.mkEnableOption "the usage of Catppuccin's binary cache";
  };

  config = {
    warnings = lib.mkIf (warn && !isMinimumVersion) [
      "catppuccin/nix will soon require version ${minimumVersion} of Nixpkgs/NixOS/home-manager."
    ];

    assertions = lib.mkIf (!warn) [
      {
        assertion = isMinimumVersion;
        message = "catppuccin/nix requires version ${minimumVersion} of Nixpkgs/NixOS/home-manager.";
      }
    ];

    nix.settings = lib.mkIf config.catppuccin.cache.enable {
      extra-substituters = [ "https://catppuccin.cachix.org" ];
      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}

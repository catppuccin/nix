{ catppuccinModules }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  catppuccinLib = import ./lib { inherit config lib pkgs; };

  minimumVersion = "25.05";
  isMinimumVersion = lib.versionAtLeast catppuccinLib.getModuleRelease minimumVersion;
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

    enableReleaseCheck = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        This option is used to determine wether to check the
        Nixpkgs/NixOS/home-manager release version and create a eval warning if
        the version does not match catppuccin/nix's minimum supported version.
      '';
    };
  };

  config = {
    warnings = lib.mkIf (config.catppuccin.enableReleaseCheck && !isMinimumVersion) [
      "catppuccin/nix will soon require version ${minimumVersion} of Nixpkgs/NixOS/home-manager."
    ];

    assertions = lib.mkIf (!config.catppuccin.enableReleaseCheck) [
      {
        assertion = isMinimumVersion;
        message = "catppuccin/nix requires version ${minimumVersion} of Nixpkgs/NixOS/home-manager.";
      }
    ];

    nix.settings = lib.mkIf config.catppuccin.cache.enable {
      substituters = [ "https://catppuccin.cachix.org" ];
      trusted-public-keys = [ "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU=" ];
    };
  };
}

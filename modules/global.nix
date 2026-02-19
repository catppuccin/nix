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
in

{
  imports = catppuccinLib.applyToModules catppuccinModules;

  options.catppuccin = {
    enable = lib.mkEnableOption ''
      Catppuccin.

      Note: for `stateVersion` < 26.05, this is equivalent to `autoEnable`,
      and there is no way to globally disable Catppuccin.
      Since 26.05, this is a more traditional `enable` option;
      `false` disables all Catppuccin modules.
    '';

    autoEnable = lib.mkEnableOption ''
      all Catppuccin integrations by default.

      Note: for `stateVersion` < 26.05, this option is equivalent to `enable`.
    '';

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

    # TODO: remove this back-compatibility implementation detail
    _enable = lib.mkOption {
      type = lib.types.bool;
      internal = true;
      readOnly = true;
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

    # Make our lives easier by centralizing the different interpretations of `enable`.
    # That way all modules can just rely on `autoEnable` being correct, and `_enable`
    # being a global enablement state.
    catppuccin = {
      # Keep `autoEnable` in sync with `enable` for releases where it didn't exist.
      autoEnable = lib.mkIf (
        !lib.versionAtLeast catppuccinLib.getModuleRelease "26.05"
      ) config.catppuccin.enable;

      _enable =
        if lib.versionAtLeast catppuccinLib.getModuleRelease "26.05" then
          config.catppuccin.enable
        else
          true;
    };

    nix.settings = lib.mkIf (config.catppuccin._enable && config.catppuccin.cache.enable) {
      extra-substituters = [ "https://catppuccin.cachix.org" ];
      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}

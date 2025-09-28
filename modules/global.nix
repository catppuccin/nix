{ catppuccinModules }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  catppuccinLib = import ./lib { inherit config lib pkgs; };
in

{
  config = {
    assertions = [ (catppuccinLib.assertMinimumVersion "25.05") ];
  };

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

    palette = lib.mkOption {
      type = (import ./palette/type.nix) lib;
      readOnly = true;
      description = "Global Catppuccin palette";
    };

    cache.enable = lib.mkEnableOption "the usage of Catppuccin's binary cache";
  };

  config = {
    nix.settings = lib.mkIf config.catppuccin.cache.enable {
      substituters = [ "https://catppuccin.cachix.org" ];
      trusted-public-keys = [ "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU=" ];
    };

    catppuccin.palette = (import ./palette/data.nix).${config.catppuccin.flavor};
  };
}

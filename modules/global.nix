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
    assertions = [ (catppuccinLib.assertMinimumVersion "24.11") ];
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
        defaultSources = import ../.sources;
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
  };
}

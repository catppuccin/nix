{ lib, ... }:
{
  config = {
    assertions = [ (lib.ctp.assertMinimumVersion "24.05") ];
  };

  options.catppuccin.plasma = {
    enable = lib.mkEnableOption "Catppuccin for plasma-manager globally";

    flavor = lib.mkOption {
      type = lib.ctp.types.flavorOption;
      default = "mocha";
      description = "plasma-manager catppuccin flavor";
    };

    accent = lib.mkOption {
      type = lib.ctp.types.colorOption;
      default = "mauve";
      description = "plasma-manager catppuccin accent";
    };

    sources =
      let
        defaultSources = import ../../.sources;
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

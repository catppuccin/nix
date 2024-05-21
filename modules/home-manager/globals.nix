{ lib, defaultSources, ... }: {
  options.catppuccin = {
    enable = lib.mkEnableOption "Catppuccin globally";

    flavour = lib.mkOption {
      type = lib.ctp.types.flavourOption;
      default = "mocha";
      description = "Global Catppuccin flavour";
    };

    accent = lib.mkOption {
      type = lib.ctp.types.accentOption;
      default = "mauve";
      description = "Global Catppuccin accent";
    };

    sources = lib.mkOption {
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

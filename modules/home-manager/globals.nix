{ lib, ... }: {
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
      default = { };
      description = "Port sources used across all options";
    };
  };
}

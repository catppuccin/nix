{ lib, ... }: {
  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };

    accent = lib.mkOption {
      type = lib.ctp.types.accentOption;
      default = "teal";
      description = "Global Catppuccin accent";
    };
  };
}

{ lib, ... }: {
  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

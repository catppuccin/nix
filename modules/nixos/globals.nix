{ config, lib, sources, ... }: {
  config.lib.catppuccin =
    let
      cfg = config.catppuccin;
    in
    rec {
      palettes = lib.importJSON "${sources.palette}/palette.json";
      palette = palettes.${cfg.flavour};
    };

  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.ctp.types.flavourOption;
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

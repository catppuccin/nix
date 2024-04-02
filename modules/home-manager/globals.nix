{ config, lib, sources, ... }: {
  config.lib.catppuccin =
    let
      cfg = config.catppuccin;
      palettes = lib.importJSON "${sources.palette}/palette.json";
      palette = palettes.${cfg.flavour};
    in
    {
      inherit palettes;
      palette = lib.attrsets.recursiveUpdate palette {
        colors.accent = palette.colors.${cfg.accent};
      };
    };

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

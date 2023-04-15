{ config, lib, ... }:
let cfg = config.programs.kitty.catppuccin;
in {
  options.programs.kitty.catppuccin = with lib; {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for kitty";
    };
  };

  config.programs.kitty = with lib;
    let
      # string -> string
      # this capitalizes the first letter in a string
      # it's used to set the theme name correctly here
      mkUpper = word:
        (toUpper (substring 0 1 word)) + (substring 1 (stringLength word) word);

      flavourUpper = mkUpper cfg.flavour;
    in mkIf cfg.enable { theme = "Catppuccin-${flavourUpper}"; };
}

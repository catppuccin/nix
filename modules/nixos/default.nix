{ lib, ... }: let
  inherit (import ../utils.nix {inherit lib;}) importModules;
in {
  imports = importModules ./.;

  options.catppuccin = {
    flavour = lib.mkOption {
      type = lib.types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

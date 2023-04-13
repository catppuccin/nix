{lib, ...}: let
  inherit (import ../utils.nix {inherit lib;}) importModules;
  inherit (lib) mkOption types;
in {
  imports = importModules ./.;

  options.catppuccin = {
    flavour = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = "latte";
      description = "Global Catppuccin flavour";
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkEnableOption mkOption types;
  inherit (builtins) fromTOML readFile;
  inherit (pkgs) fetchFromGitHub;
  cfg = config.programs.starship.catppuccin;
in {
  options.programs.starship.catppuccin = {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for starship";
    };
  };

  config.programs.starship.settings =
    mkIf cfg.enable
    ({
        format = mkDefault "$all";
        palette = "catppuccin_${cfg.flavour}";
      }
      // fromTOML (readFile
        (fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc";
            sha256 = "sha256-soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
          }
          + "/palettes/${cfg.flavour}.toml")));
}

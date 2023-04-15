{ config, pkgs, lib, ... }:
let
  cfg = config.programs.tmux.catppuccin;

  plugin = with builtins;
    with pkgs;
    let rev = "4e48b09a76829edc7b55fbb15467cf0411f07931";
    in pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin";
      version = substring 0 7 rev;
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "tmux";
        inherit rev;
        sha256 = "sha256-bXEsxt4ozl3cAzV3ZyvbPsnmy0RAdpLxHwN82gvjLdU=";
      };
    };
in {
  options.programs.tmux.catppuccin = with lib; {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for tmux";
    };
  };

  config.programs.tmux.plugins = with lib;
    mkIf cfg.enable [{
      inherit plugin;
      extraConfig = "set -g @catppuccin_flavour '${cfg.flavour}'";
    }];
}

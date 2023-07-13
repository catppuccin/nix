{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.tmux.catppuccin;
  enable = cfg.enable && config.programs.tmux.enable;

  plugin = with builtins;
    with pkgs; let
      rev = "4e48b09a76829edc7b55fbb15467cf0411f07931";
    in
    tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin";
      version = substring 0 7 rev;
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "tmux";
        inherit rev;
        sha256 = "sha256-bXEsxt4ozl3cAzV3ZyvbPsnmy0RAdpLxHwN82gvjLdU=";
      };
    };
in
{
  options.programs.tmux.catppuccin =
    lib.ctp.mkCatppuccinOpt "tmux" config;

  config.programs.tmux.plugins = lib.mkIf enable [
    {
      inherit plugin;
      extraConfig = "set -g @catppuccin_flavour '${cfg.flavour}'";
    }
  ];
}

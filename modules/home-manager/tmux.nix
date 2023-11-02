{ config
, lib
, pkgs
, sources
, ...
}:
let
  cfg = config.programs.tmux.catppuccin;
  enable = cfg.enable && config.programs.tmux.enable;

  plugin =
    # TODO @getchoo: upstream this in nixpkgs
    pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin";
      version = builtins.substring 0 7 sources.tmux.rev;
      src = sources.tmux;
    };
in
{
  options.programs.tmux.catppuccin =
    lib.ctp.mkCatppuccinOpt "tmux";

  config.programs.tmux.plugins = lib.mkIf enable [
    {
      inherit plugin;
      extraConfig = "set -g @catppuccin_flavour '${cfg.flavour}'";
    }
  ];
}

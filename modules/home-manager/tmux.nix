{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) ctp mkOption types concatStrings;
  inherit (config.catppuccin) sources;
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
    ctp.mkCatppuccinOpt "tmux"
    // {
      extraConfig = mkOption {
        type = types.lines;
        description = "Additional configuration for the catppuccin plugin.";
        default = "";
        example = ''
          set -g @catppuccin_status_modules_right "application session user host date_time"
        '';
      };
    };

  config.programs.tmux.plugins = lib.mkIf enable [
    {
      inherit plugin;
      extraConfig = concatStrings [
        ''
          set -g @catppuccin_flavour '${cfg.flavour}'
        ''
        cfg.extraConfig
      ];
    }
  ];
}

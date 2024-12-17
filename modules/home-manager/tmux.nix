{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.programs.tmux.catppuccin;

  plugin =
    # TODO @getchoo: upstream this in nixpkgs
    pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin";
      version = builtins.substring 0 7 sources.tmux.revision;
      src = sources.tmux;
    };
in

{
  options.programs.tmux.catppuccin = catppuccinLib.mkCatppuccinOption { name = "tmux"; } // {
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      description = "Additional configuration for the catppuccin plugin.";
      default = "";
      example = ''
        set -g @catppuccin_status_modules_right "application session user host date_time"
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      plugins = [
        {
          inherit plugin;
          extraConfig = lib.concatStrings [
            ''
              set -g @catppuccin_flavor '${cfg.flavor}'
            ''
            cfg.extraConfig
          ];
        }
      ];
    };
  };
}

{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    ctp
    mkOption
    types
    concatStrings
    ;
  cfg = config.programs.tmux.catppuccin;
  enable = cfg.enable && config.programs.tmux.enable;
in
{
  options.programs.tmux.catppuccin = ctp.mkCatppuccinOpt { name = "tmux"; } // {
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
      plugin = config.catppuccin.sources.tmux;
      extraConfig = concatStrings [
        ''
          set -g @catppuccin_flavor '${cfg.flavor}'
        ''
        cfg.extraConfig
      ];
    }
  ];
}

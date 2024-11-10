{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    ctp
    mkOption
    types
    concatStrings
    ;
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.tmux;
  enable = cfg.enable && config.programs.tmux.enable;

  plugin =
    # TODO @getchoo: upstream this in nixpkgs
    pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin";
      version = builtins.substring 0 7 sources.tmux.revision;
      src = sources.tmux;
    };
in
{
  options.catppuccin.tmux = ctp.mkCatppuccinOpt { name = "tmux"; } // {
    extraConfig = mkOption {
      type = types.lines;
      description = "Additional configuration for the catppuccin plugin.";
      default = "";
      example = ''
        set -g @catppuccin_status_modules_right "application session user host date_time"
      '';
    };
  };

  imports =
    (lib.ctp.mkRenamedCatppuccinOpts {
      from = [
        "programs"
        "tmux"
        "catppuccin"
      ];
      to = "tmux";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "tmux"
          "catppuccin"
          "extraConfig"
        ]
        [
          "catppuccin"
          "tmux"
          "extraConfig"
        ]
      )
    ];

  config.programs.tmux.plugins = lib.mkIf enable [
    {
      inherit plugin;
      extraConfig = concatStrings [
        ''
          set -g @catppuccin_flavor '${cfg.flavor}'
        ''
        cfg.extraConfig
      ];
    }
  ];
}

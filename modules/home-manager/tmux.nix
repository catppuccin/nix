{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.tmux;
in

{
  options.catppuccin.tmux = catppuccinLib.mkCatppuccinOption { name = "tmux"; } // {
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      description = "Additional configuration for the catppuccin plugin.";
      default = "";
      example = ''
        set -g @catppuccin_status_modules_right "application session user host date_time"
      '';
    };
  };

  imports =
    (catppuccinLib.mkRenamedCatppuccinOptions {
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

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      plugins = [
        {
          plugin = config.catppuccin.sources.tmux;
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

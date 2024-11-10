{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.waybar;
  enable = cfg.enable && config.programs.waybar.enable;
  styleFile = "${sources.waybar}/themes/${cfg.flavor}.css";
in
{
  options.catppuccin.waybar = lib.ctp.mkCatppuccinOpt { name = "waybar"; } // {
    mode = lib.mkOption {
      type = lib.types.enum [
        "prependImport"
        "createLink"
      ];
      default = "prependImport";
      description = ''
        Defines how to include the catppuccin theme css file:

        - `prependImport`: Prepends the import statement, if `programs.waybar.style` is a string (with default override priority).
        - `createLink`: Creates a symbolic link `~/.config/waybar/catppuccin.css`, which needs to be included in the waybar stylesheet.
      '';
    };
  };

  imports =
    (lib.ctp.mkRenamedCatppuccinOpts {
      from = [
        "programs"
        "waybar"
        "catppuccin"
      ];
      to = "waybar";
    })
    ++ [
      (lib.mkRenamedOptionModule
        [
          "programs"
          "waybar"
          "catppuccin"
          "mode"
        ]
        [
          "catppuccin"
          "waybar"
          "mode"
        ]
      )
    ];

  config = lib.mkIf enable (
    lib.mkMerge [
      (lib.mkIf (cfg.mode == "prependImport") {
        programs.waybar.style = lib.mkBefore ''
          @import "${styleFile}";
        '';
      })
      (lib.mkIf (cfg.mode == "createLink") { xdg.configFile."waybar/catppuccin.css".source = styleFile; })
    ]
  );
}

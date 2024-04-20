{ config
, lib
, sources
, ...
}:
let
  cfg = config.programs.waybar.catppuccin;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  options.programs.waybar.catppuccin = (lib.ctp.mkCatppuccinOpt "waybar") // {
    styleFile = lib.mkOption {
      type = lib.types.path;
      default = "${sources.waybar}/themes/${cfg.flavour}.css";
      description = "Path to CSS file containing color variable definitions";
    };

    prependImport = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to prepend `@import \"$${styleFile}\";` when `programs.waybar.style` is set to a string.";
    };

    createLink = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to create a symlink `~/.config/waybar/catppuccin.css` pointing to `styleFile`.";
    };
  };

  config = lib.mkIf enable {
    programs.waybar.style = lib.mkIf cfg.prependImport (
      lib.mkBefore ''
        @import "${cfg.styleFile}";
      ''
    );

    xdg.configFile."waybar/catppuccin.css" = lib.mkIf cfg.createLink { source = cfg.styleFile; };
  };
}

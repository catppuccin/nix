{
  config,
  lib,
  sources,
  ...
}:
let
  cfg = config.programs.waybar.catppuccin;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  options.programs.waybar.catppuccin = (lib.ctp.mkCatppuccinOpt "waybar") // {
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

  config = lib.mkIf enable (
    let
      styleFile = "${sources.waybar}/themes/${cfg.flavour}.css";
    in
    {
      programs.waybar.style = lib.mkIf cfg.prependImport (
        lib.mkBefore ''
          @import "${styleFile}";
        ''
      );

      xdg.configFile."waybar/catppuccin.css" = lib.mkIf cfg.createLink { source = styleFile; };
    }
  );
}

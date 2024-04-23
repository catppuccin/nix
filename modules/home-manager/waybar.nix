{ config
, options
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
    mode = lib.mkOption {
      type = lib.types.enum [
        "prependImport"
        "createLink"
      ];
      default = "prependImport";
      description = "Whether to prepend an `@import` (requires that `programs.waybar.style` is set to a string) or to create a symlink `~/.config/waybar/catppuccin.css` (requires you to import manually).";
    };
  };

  config = lib.mkIf enable (
    let
      styleFile = "${sources.waybar}/themes/${cfg.flavour}.css";
    in
    {
      warnings =
        lib.optional
          (
            cfg.mode == "prependImport"
            && options.programs.waybar.style.highestPrio < lib.modules.defaultOverridePriority
          )
          "`programs.waybar.style` is set to a string with a lower priority value than the default ${toString lib.modules.defaultOverridePriority}. `programs.waybar.catppucccin.mode = \"prependImport\"` will have no effect.";

      programs.waybar.style = lib.mkIf (cfg.mode == "prependImport") (
        lib.mkBefore ''
          @import "${styleFile}";
        ''
      );

      xdg.configFile."waybar/catppuccin.css" = lib.mkIf (cfg.mode == "createLink") {
        source = styleFile;
      };
    }
  );
}

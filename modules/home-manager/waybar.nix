{ config
, options
, lib
, sources
, ...
}:
let
  cfg = config.programs.waybar.catppuccin;
  enable = cfg.enable && config.programs.waybar.enable;
  styleFile = "${sources.waybar}/themes/${cfg.flavour}.css";
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
    lib.mkMerge [
      (lib.mkIf (cfg.mode == "prependImport") {
        warnings =
          lib.optional (options.programs.waybar.style.highestPrio < lib.modules.defaultOverridePriority)
            "`programs.waybar.style` is set to a string with a lower priority value than the default ${toString lib.modules.defaultOverridePriority}. `programs.waybar.catppucccin.mode = \"prependImport\"` will have no effect.";

        programs.waybar.style = lib.mkBefore ''
          @import "${styleFile}";
        '';
      })
      (lib.mkIf (cfg.mode == "createLink") {
        xdg.configFile."waybar/catppuccin.css".source = styleFile;
      })
    ]
  );
}

{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  
  cfg = config.catppuccin.sioyek;
  enable = cfg.enable && config.programs.sioyek.enable;
  
  themeFile = "/catppuccin-${cfg.flavor}.config";
  theme = sources.sioyek + themeFile;
in
 
{
  options.catppuccin.sioyek = 
    catppuccinLib.mkCatppuccinOption {
      name = "sioyek";
    }
    // {
      applyOnStartup = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Applies the theme by adding `toggle_custom_color` to `startup_commands` in sioyek's config.
          If this is disabled, you must manually run `toggle_custom_colors` in Sioyek to enable the theme.
        '';
      };
    };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "sioyek"
      "catppuccin"
    ];
    to = "sioyek";
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "sioyek/prefs_user.config".source = theme;
    };
    
    programs.sioyek.config = lib.mkIf cfg.applyOnStartup {
      startup_commands = lib.mkBefore "toggle_custom_color;";
    };
  };
} 
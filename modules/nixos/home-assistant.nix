{ catppuccinLib }:
{
  lib,
  config,
  ...
}:
let
  inherit (config.catppuccin) sources;
  inherit (lib) singleton toSentenceCase;

  cfg = config.catppuccin.home-assistant;
in
{
  options.catppuccin.home-assistant =
    catppuccinLib.mkCatppuccinOption {
      name = "home-assistant";
      accentSupport = true;
    }
    // {
      setDefaultAtStartup = lib.mkEnableOption "setting the default theme at Home Assistant startup" // {
        default = true;
        example = false;
      };
    };

  config = lib.mkIf cfg.enable {
    services.home-assistant.config = {
      frontend.themes = "!include_dir_merge_named ${sources.home-assistant}";

      "automation catppuccin" = lib.mkIf cfg.setDefaultAtStartup {
        alias = "Catppuccin default theme";
        id = "catppuccin_default_theme";
        description = "Sets the default frontend theme to ${catppuccinLib.mkFlavorName cfg.flavor} at startup.";
        mode = "single";
        triggers = singleton {
          trigger = "homeassistant";
          event = "start";
        };
        actions = singleton {
          action = "frontend.set_theme";
          data = {
            name = "Catppuccin ${toSentenceCase cfg.flavor} ${toSentenceCase cfg.accent}";
            name_dark = "none";
          };
        };
      };
    };
  };
}

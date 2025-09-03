{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.wezterm;
in
{
  options.catppuccin.wezterm =
    catppuccinLib.mkCatppuccinOption {
      name = "wezterm";
      accentSupport = true;
    }
    // {
      apply = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Apply Catppuccin theme to WezTerm.";
      };
    };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      extraConfig = lib.mkBefore (
        ''
          local catppuccin_plugin = "${sources.wezterm}/plugin/init.lua"
          local catppuccin_config = {
            flavor = "${cfg.flavor}",
            accent = "${cfg.accent}",
          }
        ''
        + lib.optionalString cfg.apply ''
          local config = {}
          if wezterm.config_builder then
            config = wezterm.config_builder()
          end

          dofile("${sources.wezterm}/plugin/init.lua").apply_to_config(config, catppuccin_config)
        ''
      );
    };
  };
}

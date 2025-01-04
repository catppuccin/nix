{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.wezterm;
  applyWeztermTheme = config.catppuccin.wezterm.apply or false;
in
{
  options.catppuccin.wezterm = catppuccinLib.mkCatppuccinOption { name = "wezterm"; };

  options.catppuccin.wezterm.apply = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Apply Catppuccin theme to WezTerm.";
  };

  config = lib.mkIf (cfg.enable && applyWeztermTheme) {
    programs.wezterm = {
      colorSchemes."catppuccin-${cfg.flavor}" = lib.importTOML "${sources.wezterm}/dist/catppuccin-${cfg.flavor}.toml";
      extraConfig = lib.mkBefore ''
        local config = {}
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        dofile("${sources.wezterm}/plugin/init.lua").apply_to_config(config)
      '';
    };
  };
}

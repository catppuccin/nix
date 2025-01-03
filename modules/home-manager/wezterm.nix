{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.wezterm;
in

{
  options.catppuccin.wezterm = catppuccinLib.mkCatppuccinOption { name = "wezterm"; };


  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      colorSchemes."catppuccin-${cfg.flavor}" = lib.importTOML "${sources.wezterm}/dist/catppuccin-${cfg.flavor}.toml";
      extraConfig = lib.mkBefore ''
        local config = {}
        if wezterm.c_builder then
          config = wezterm.config_builder()
        end

        dofile("${sources.wezterm}/plugin/init.lua").apply_to_config(config)
      '';
    };
  };
}

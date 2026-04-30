{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.wezterm;

  defaultConfig = {
    inherit (cfg) flavor accent;
  };
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
        description = ''
          Apply Catppuccin theme to WezTerm

          :::note
          This option has no effect if you are using {option}`programs.wezterm.settings`
          :::
        '';
      };

      settings = lib.mkOption {
        description = "Extra settings that will be passed to the setup function.";
        default = { };
        type = lib.types.submodule { freeformType = lib.types.attrsOf lib.types.anything; };
        apply = lib.recursiveUpdate defaultConfig;
      };
    };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      extraConfig = lib.mkBefore (
        ''
          local catppuccin_plugin = "${sources.wezterm}/plugin/init.lua"
          local catppuccin_config = ${lib.generators.toLua { } cfg.settings}
        ''
        + lib.optionalString ((config.programs.wezterm.settings == { }) && cfg.apply) ''
          local config = {}
          if wezterm.config_builder then
            config = wezterm.config_builder()
          end
        ''
        + lib.optionalString ((config.programs.wezterm.settings != { }) || cfg.apply) ''
          dofile("${sources.wezterm}/plugin/init.lua").apply_to_config(config, catppuccin_config)
        ''
      );
    };
  };
}

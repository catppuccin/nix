{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.vscode;

  usesPerProfileCfg = lib.versionAtLeast catppuccinLib.getModuleRelease "25.05";
  settings = {
    extensions = [ (sources.vscode.override { catppuccinOptions = cfg.settings; }) ];

    userSettings = {
      "workbench.colorTheme" =
        "Catppuccin " + (if cfg.flavor == "frappe" then "Frappé" else catppuccinLib.mkUpper cfg.flavor);
      "catppuccin.accentColor" = cfg.accent;

      # Recommended settings
      # https://github.com/catppuccin/vscode?tab=readme-ov-file#vscode-settings
      "editor.semanticHighlighting.enabled" = lib.mkDefault true;
      "terminal.integrated.minimumContrastRatio" = lib.mkDefault 1;
      "window.titleBarStyle" = lib.mkDefault "custom";
    };
  };

  settingsFormat = pkgs.formats.json { };

  settingsSubmodule = {
    freeformType = settingsFormat.type;

    options = {
      accent = lib.mkOption {
        type = catppuccinLib.types.accent;
        default = cfg.accent;
      };
    };
  };
in

{
  options.catppuccin.vscode =
    catppuccinLib.mkCatppuccinOption {
      name = "vscode";
      accentSupport = true;
    }
    // {
      settings = lib.mkOption {
        description = "Extra settings that will be passed to the vscode build.";
        default = { };
        type = lib.types.submodule settingsSubmodule;
      };
    };

  config = lib.mkIf cfg.enable {
    # TODO: Remove compat layer when 25.05 is stable
    # https://github.com/nix-community/home-manager/pull/5640
    programs.vscode =
      if usesPerProfileCfg then
        {
          profiles.default = settings;
        }
      else
        settings;
  };
}

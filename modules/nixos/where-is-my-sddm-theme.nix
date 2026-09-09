{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (catppuccinLib) importINI;
  inherit (lib)
    mkOption
    recursiveUpdate
    singleton
    types
    ;

  cfg = config.catppuccin.where-is-my-sddm-theme;
  enable = cfg.enable && config.services.displayManager.sddm.enable;
in

{
  options.catppuccin.where-is-my-sddm-theme =
    catppuccinLib.mkCatppuccinOption {
      name = "where-is-my-sddm-theme";
      default = config.catppuccin.enable && !config.catppuccin.sddm.enable;
      defaultText = "config.catppuccin.enable && !config.catppuccin.sddm.enable";
    }
    // {
      variant = mkOption {
        type = types.enum [
          "qt5"
          "qt6"
        ];
        default =
          if config.services.displayManager.sddm.package == pkgs.libsForQt5.sddm then "qt5" else "qt6";
        defaultText = "Automatically determined based on your SDDM package - `qt6` for `kdePackages.sddm`, `qt5` for `libsForQt5.sddm`, and `qt6` as fallback";
        example = "qt5";
        description = "Which variant will be used for Where is my SDDM theme?";
      };

      settings = mkOption {
        type = lib.types.submodule { freeformType = with types; attrsOf anything; };
        default = { };
        example = {
          General.passwordCharacter = "*";
        };
        description = "Additional settings for Where is my SDDM theme?";
      };
    };

  config = lib.mkIf enable {
    assertions = [
      {
        assertion = config.catppuccin.sddm.enable -> cfg.enable;
        message = "Only one of `catppuccin.sddm` and `catppuccin.where-is-my-sddm-theme` may be set at a time.";
      }
    ];

    environment.systemPackages = [
      (pkgs.where-is-my-sddm-theme.override {
        variants = singleton cfg.variant;
        themeConfig = recursiveUpdate (importINI "${config.catppuccin.sources.where-is-my-sddm-theme}/catppuccin-${cfg.flavor}.conf") cfg.settings;
      })
    ];

    services.displayManager = {
      sddm = {
        theme =
          if cfg.variant == "qt6" then "where_is_my_sddm_theme" else "where_is_my_sddm_theme_qt5";
      };
    };
  };
}

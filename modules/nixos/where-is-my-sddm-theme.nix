{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins) elem;
  inherit (catppuccinLib) importINI;
  inherit (lib)
    literalMD
    mkOption
    recursiveUpdate
    types
    ;

  cfg = config.catppuccin.where-is-my-sddm-theme;
  enable = cfg.enable && config.services.displayManager.sddm.enable;
in

{
  options.catppuccin.where-is-my-sddm-theme =
    catppuccinLib.mkCatppuccinOption {
      name = "where-is-my-sddm-theme";
    }
    // {
      defaultVariant = mkOption {
        type = types.enum [
          "qt5"
          "qt6"
        ];
        default =
          if config.services.displayManager.sddm.package == pkgs.kdePackages.sddm then
            "qt6"
          else if config.services.displayManager.sddm.package == pkgs.libsForQt5.sddm then
            "qt5"
          else
            "qt6";
        defaultText = literalMD "Automatically determined based on your SDDM package - `qt6` for `kdePackages.sddm`, `qt5` for `libsForQt5.sddm`, and `qt6` as fallback";
        example = "qt5";
        description = "Which variant will be used";
      };

      settings = mkOption {
        type = with types; attrsOf anything;
        default = { };
        example = {
          General.passwordCharacter = "*";
        };
        description = "Additional settings for Where is my SDDM theme?";
      };

      variants = mkOption {
        type =
          with types;
          listOf (enum [
            "qt5"
            "qt6"
          ]);
        default = [ "qt6" ];
        example = [ "qt5" ];
        description = "Where is my SDDM theme variants to install";
      };
    };

  config = lib.mkIf enable {
    assertions = [
      {
        assertion = elem cfg.defaultVariant cfg.variants;
        message = ''
          The selected default variant '${cfg.defaultVariant}' for Where is my SDDM theme is not included in the variants to install (${toString cfg.variants}).
          Either add '${cfg.defaultVariant}' to the variants list or change the defaultVariant to one that is being installed.
        '';
      }
    ];

    environment.systemPackages = [
      (pkgs.where-is-my-sddm-theme.override {
        inherit (cfg) variants;
        themeConfig = recursiveUpdate (importINI "${config.catppuccin.sources.where-is-my-sddm-theme}/catppuccin-${cfg.flavor}.conf") cfg.settings;
      })
    ];

    services.displayManager = {
      sddm = {
        theme =
          if cfg.defaultVariant == "qt6" then "where_is_my_sddm_theme" else "where_is_my_sddm_theme_qt5";
      };
    };
  };
}

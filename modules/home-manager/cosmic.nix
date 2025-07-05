{ catppuccinLib }:
{
  config,
  cosmicLib,
  lib,
  ...
}:
let
  cfg = config.catppuccin;
in
{
  options.catppuccin = {
    cosmic = catppuccinLib.mkCatppuccinOption {
      accentSupport = true;
      name = "cosmic";
      useGlobalEnable = false;
    };

    cosmic-term = catppuccinLib.mkCatppuccinOption {
      name = "cosmic-term";
      useGlobalEnable = false;
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = config._module.args ? cosmicLib;
          message = "COSMIC Theming requires cosmic-manager module to be available.";
        }
      ];
    }

    (lib.mkIf cfg.cosmic.enable {
      wayland.desktopManager.cosmic.appearance.theme = {
        ${if cfg.cosmic.flavor == "latte" then "light" else "dark"} =
          cosmicLib.cosmic.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/cosmic-settings/catppuccin-${cfg.cosmic.flavor}-${cfg.cosmic.accent}+round.ron";
        mode = if cfg.cosmic.flavor == "latte" then "light" else "dark";
      };
    })

    (lib.mkIf cfg.cosmic-term.enable {
      programs.cosmic-term.colorSchemes = [
        (cosmicLib.cosmic.ron.importRON "${config.catppuccin.sources.cosmic-desktop}/cosmic-term/catppuccin-${cfg.cosmic-term.flavor}.ron")
      ];
    })
  ];
}

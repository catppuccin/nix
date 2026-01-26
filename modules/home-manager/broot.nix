{ catppuccinLib }:
{
  config,
  lib,
  ...
}:
let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.broot;
  enable = cfg.enable && config.programs.broot.enable;

  themeFile = "catppuccin-${cfg.flavor}-${cfg.accent}.hjson";
in
{
  options.catppuccin.broot = catppuccinLib.mkCatppuccinOption {
    name = "broot";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    xdg.configFile = {
      "broot/skins/${themeFile}".source = "${sources.broot}/${cfg.flavor}/${themeFile}";
    };

    programs.broot = {
      settings = {
        imports = [
          {
            file = "skins/${themeFile}";
            luma = "light";
          }
          {
            file = "skins/${themeFile}";
            luma = [
              "dark"
              "unknown"
            ];
          }
        ];
      };
    };
  };
}

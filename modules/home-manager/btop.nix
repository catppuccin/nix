{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.btop.catppuccin;
  enable = cfg.enable && config.programs.btop.enable;

  themeFile = "catppuccin_${cfg.flavour}.theme";
  themePath = "/themes/${themeFile}";
  theme =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "btop";
        rev = "7109eac2884e9ca1dae431c0d7b8bc2a7ce54e54";
        sha256 = "sha256-QoPPx4AzxJMYo/prqmWD/CM7e5vn/ueyx+XQ5+YfHF8=";
      }
    + themePath;
in
{
  options.programs.btop.catppuccin =
    lib.ctp.mkCatppuccinOpt "btop" config;

  config = mkIf enable
    {
      xdg = {
        # xdg is required for this to work
        enable = lib.mkForce true;
        configFile."btop${themePath}".source = theme;
      };

      programs.btop.settings.color_theme = themeFile;
    };
}

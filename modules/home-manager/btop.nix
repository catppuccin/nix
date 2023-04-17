{ config, pkgs, lib, ... }:
let
  cfg = config.programs.btop.catppuccin;
  themePath = "/themes/catppuccin_${cfg.flavour}.theme";
  theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "7109eac2884e9ca1dae431c0d7b8bc2a7ce54e54";
    sha256 = "sha256-QoPPx4AzxJMYo/prqmWD/CM7e5vn/ueyx+XQ5+YfHF8=";
  } + themePath;
in {
  options.programs.btop.catppuccin =
    lib.ctp.mkCatppuccinOpt "btop" config;

  # xdg is required for this to work
  config.xdg.enable = with lib; mkIf cfg.enable (mkForce true);

  config.xdg.configFile."btop${themePath}".source = with lib;
    mkIf cfg.enable theme;

  config.programs.btop.settings.color_theme = with lib;
    mkIf cfg.enable "${config.xdg.configHome + "/btop/${themePath}"}";
}

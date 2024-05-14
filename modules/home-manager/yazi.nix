{ config
, lib
, ...
}:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;

  cfg = config.programs.yazi.catppuccin;
  enable = cfg.enable && config.programs.yazi.enable;
in
{
  options.programs.yazi.catppuccin =
    ctp.mkCatppuccinOpt "yazi";

  config = lib.mkIf enable {
    assertions = [
      (lib.ctp.assertXdgEnabled "yazi")
    ];

    programs.yazi.theme = lib.importTOML "${sources.yazi}/themes/${cfg.flavour}.toml";
    xdg.configFile."yazi/Catppuccin-${cfg.flavour}.tmTheme".source = "${sources.bat}/themes/Catppuccin ${ctp.mkUpper cfg.flavour}.tmTheme";
  };
}

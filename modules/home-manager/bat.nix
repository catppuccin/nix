{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.bat.catppuccin;
  enable = cfg.enable && config.programs.bat.enable;
in
{
  options.programs.bat.catppuccin =
    lib.ctp.mkCatppuccinOpt "bat" config;

  config = {
    programs.bat = lib.mkIf enable {
      config.theme = "Catppuccin-${cfg.flavour}";
      themes."Catppuccin-${cfg.flavour}" = {
        src =
          pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
            };
        file = "Catppuccin-${cfg.flavour}.tmTheme";
      };
    };
  };
}

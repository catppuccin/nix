{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.micro.catppuccin;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "catppuccin-${cfg.flavour}.micro";
  theme =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "micro";
        rev = "ed8ef015f97c357575b5013e18042c9faa6c068a";
        sha256 = "/JwZ+5bLYjZWcV5vH22daLqVWbyJelqRyGa7V0b7EG8=";
      }
    + "/src/${themePath}";
in
{
  options.programs.micro.catppuccin =
    lib.ctp.mkCatppuccinOpt "micro" config;

  config = lib.mkIf enable {
    programs.micro.settings.colorscheme = lib.removeSuffix ".micro" themePath;

    xdg = {
      # xdg is required for this to work
      enable = lib.mkForce true;
      configFile."micro/colorschemes/${themePath}".source = theme;
    };
  };
}
}

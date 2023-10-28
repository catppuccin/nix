{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.micro.catppuccin;
  enable = cfg.enable && config.programs.micro.enable;

  themePath = "/catppuccin-${cfg.flavour}.micro";
  theme =
    pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "micro";
        rev = "ed8ef015f97c357575b5013e18042c9faa6c068a";
        sha256 = "/JwZ+5bLYjZWcV5vH22daLqVWbyJelqRyGa7V0b7EG8=";
      }
    + "/src"
    + themePath;
in
{
  options.programs.micro.catppuccin =
    lib.ctp.mkCatppuccinOpt "micro" config;

  # xdg is required for this to work
  config =
    {
      xdg.enable = mkIf enable (lib.mkForce true);
    }
    // (lib.mkIf enable {
      xdg.configFile."micro/colorschemes${themePath}".source = theme;
    });
}

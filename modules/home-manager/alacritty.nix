{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.alacritty.catppuccin;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.programs.alacritty.catppuccin =
    ctp.mkCatppuccinOpt "alacritty" config;

  config.programs.alacritty.settings =
    let
      file =
        pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "alacritty";
            rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
            sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
          }
        + "/catppuccin-${cfg.flavour}.yml";
    in
    lib.mkIf enable (ctp.fromYaml pkgs file);
}

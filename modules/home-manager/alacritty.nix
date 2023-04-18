{ config, pkgs, lib, ... }:
let cfg = config.programs.alacritty.catppuccin;
in {
  options.programs.alacritty.catppuccin =
    lib.ctp.mkCatppuccinOpt "alacritty" config;

  config.programs.alacritty.settings = with builtins;
    with lib;
    with pkgs;
    let
      file = fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "alacritty";
          rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
          sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
        } + "/catppuccin-${cfg.flavour}.yml";

    in
    mkIf cfg.enable (ctp.fromYaml pkgs file);
}

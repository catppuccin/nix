{ config, pkgs, lib, ... }:
let cfg = config.programs.lazygit.catppuccin;
in {
  options.programs.lazygit.catppuccin =
    lib.ctp.mkCatppuccinOpt "lazygit" config;

  config.programs.lazygit.settings = with builtins;
    with lib;
    with pkgs;
    let
      file = fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "lazygit";
          rev = "f01edfd57fa2aa7cd69a92537a613bb3c91e65dd";
          sha256 = "sha256-zjzDtXcGtUon4QbrZnlAPzngEyH56yy8TCyFv0rIbOA=";
        } + "/themes/catppuccin-${cfg.flavour}.yml";

    in
    mkIf cfg.enable (ctp.fromYaml pkgs file);
}

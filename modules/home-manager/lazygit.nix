{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;
in
{
  options.programs.lazygit.catppuccin =
    lib.ctp.mkCatppuccinOpt "lazygit" config;

  config.programs.lazygit.settings =
    let
      file =
        pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "lazygit";
            rev = "f01edfd57fa2aa7cd69a92537a613bb3c91e65dd";
            sha256 = "sha256-zjzDtXcGtUon4QbrZnlAPzngEyH56yy8TCyFv0rIbOA=";
          }
        + "/themes/${cfg.flavour}.yml";
    in
    lib.mkIf enable (lib.ctp.fromYaml pkgs file);
}

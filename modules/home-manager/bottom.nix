{ config
, pkgs
, lib
, ...
}:
let
  inherit (builtins) fromTOML readFile;
  cfg = config.programs.bottom.catppuccin;
  enable = cfg.enable && config.programs.bottom.enable;
in
{
  options.programs.bottom.catppuccin =
    lib.ctp.mkCatppuccinOpt "bottom" config;

  config.programs.bottom.settings = lib.mkIf enable (fromTOML (readFile (pkgs.fetchFromGitHub
    {
      owner = "catppuccin";
      repo = "bottom";
      rev = "c0efe9025f62f618a407999d89b04a231ba99c92";
      sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
    }
  + "/themes/${cfg.flavour}.toml")));
}

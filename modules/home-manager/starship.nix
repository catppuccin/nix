{ config
, pkgs
, lib
, ...
}:
let
  inherit (builtins) fromTOML readFile;
  cfg = config.programs.starship.catppuccin;
  enable = cfg.enable && config.programs.starship.enable;
in
{
  options.programs.starship.catppuccin =
    lib.ctp.mkCatppuccinOpt "starship" config;

  config.programs.starship.settings =
    lib.mkIf enable
      ({
        format = lib.mkDefault "$all";
        palette = "catppuccin_${cfg.flavour}";
      }
      // fromTOML (readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc";
            sha256 = "sha256-soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
          }
        + "/palettes/${cfg.flavour}.toml")));
}

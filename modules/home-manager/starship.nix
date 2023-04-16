{ config, pkgs, lib, ... }:
let cfg = config.programs.starship.catppuccin; in
{
  options.programs.starship.catppuccin =
    lib.ctp.mkCatppuccinOpt "starship" config;

  config.programs.starship.settings = lib.mkIf cfg.enable
    ({
      format = lib.mkDefault "$all";
      palette = "catppuccin_${cfg.flavour}";
    } // builtins.fromTOML (builtins.readFile
      (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "starship";
          rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc";
          sha256 = "sha256-soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
        } + /palettes/${cfg.flavour}.toml)));
}

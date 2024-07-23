{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.hyprlock.catppuccin;
  enable = cfg.enable && config.programs.hyprlock.enable;
in
{
  options.programs.hyprlock.catppuccin = lib.ctp.mkCatppuccinOpt { name = "hyprlock"; } // {
    accent = lib.ctp.mkAccentOpt "hyprlock";
  };

  config = lib.mkIf enable {
    programs.hyprlock.settings.source = [
      # source theme colors
      "${sources.hyprland}/themes/${cfg.flavor}.conf"

      # define accent color
      (builtins.toFile "hyprlock-${cfg.accent}.conf" ''
        $accent=''$${cfg.accent}
        $accentAlpha=''$${cfg.accent}Alpha
      '')

      # source port with patches to make it work from the box
      (pkgs.runCommand "hyprlock-catppuccin.conf" { } ''
        cat ${sources.hyprlock}/hyprlock.conf > $out
        patch -p1 $out ${./conf.patch}
      '').outPath
    ];
  };
}

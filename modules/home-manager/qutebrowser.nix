{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.qutebrowser;
  enable = cfg.enable && config.programs.qutebrowser.enable;

  files = {
    "qutebrowser/catppuccin".source = sources.qutebrowser;
  };
in

{
  options.catppuccin.qutebrowser = catppuccinLib.mkCatppuccinOption { name = "qutebrowser"; };

  config = lib.mkIf enable {
    programs.qutebrowser = {
      extraConfig = lib.mkMerge [
        (lib.mkBefore "import catppuccin")
        (lib.mkAfter "catppuccin.setup(c, '${cfg.flavor}', True)")
      ];
    };

    home.file = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
      lib.mapAttrs' (name: lib.nameValuePair ("." + name)) files
    );

    xdg.configFile = lib.mkIf pkgs.stdenv.hostPlatform.isLinux files;
  };
}

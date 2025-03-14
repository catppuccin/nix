{ catppuccinLib }:
{ pkgs, config, lib, ... }: let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.qutebrowser;
  enable = cfg.enable && config.programs.qutebrowser.enable;
in {
  options.catppuccin.qutebrowser = catppuccinLib.mkCatppuccinOption { name = "qutebrowser"; };

  config = lib.mkIf enable {
    home.file = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      ".qutebrowser/config.py".text = lib.mkMerge [
        (lib.mkBefore "import catppuccin")
        (lib.mkAfter "catppuccin.setup(c, '${cfg.flavor}', True)")
      ];

      ".qutebrowser/catppuccin".source = sources.qutebrowser;
    };

    xdg.configFile = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      "qutebrowser/config.py".text = lib.mkMerge [
        (lib.mkBefore "import catppuccin")
        (lib.mkAfter "catppuccin.setup(c, '${cfg.flavor}', True)")
      ];

      "qutebrowser/catppuccin".source = sources.qutebrowser;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) readFile;
  inherit (lib) mkEnableOption mkIf mkOption types;
  inherit (pkgs) bat fetchFromGitHub;
  cfg = config.programs.bat.catppuccin;
in {
  options.programs.bat.catppuccin = {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for bat";
    };
  };

  config = {
    home.activation.batCache = "${bat}/bin/bat cache --build";

    programs.bat = mkIf cfg.enable {
      config.theme = "Catppuccin-${cfg.flavour}";
      themes."Catppuccin-${cfg.flavour}" = readFile (fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        }
        + "/Catppuccin-${cfg.flavour}.tmTheme");
    };
  };
}

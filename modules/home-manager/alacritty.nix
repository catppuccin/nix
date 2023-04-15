{ config, pkgs, lib, ... }:
let cfg = config.programs.alacritty.catppuccin;
in {
  options.programs.alacritty.catppuccin = with lib; {
    enable = mkEnableOption "Catppuccin theme";
    flavour = mkOption {
      type = types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = config.catppuccin.flavour;
      description = "Catppuccin flavour for alacritty";
    };
  };

  config.programs.alacritty.settings = with builtins;
    with lib;
    with pkgs;
    let
      # path -> a
      # fromJSON but for yaml
      fromYaml = file:
        let
          # convert to json
          json = runCommand "converted.json" { } ''
            ${yj}/bin/yj < ${file} > $out
          '';
        in fromJSON (readFile json);

      file = fetchFromGitHub {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
        sha256 = "sha256-w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
      } + "/catppuccin-${cfg.flavour}.yml";

    in mkIf cfg.enable (fromYaml file);
}

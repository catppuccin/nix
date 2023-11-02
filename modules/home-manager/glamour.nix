{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.glamour.catppuccin;
  inherit (cfg) enable;

  version = "1.0.0";

  hashes = {
    latte = "sha256-V0LsRStF1vL+Tz8G6VaKiwiY/ZIsSkMc+f1WJAITYXU=";
    frappe = "sha256-YOatgYCJKuesVERHZVmF1xtzuLjyxCYstoWYqATq+NU=";
    macchiato = "sha256-CeSJvhjzHVTtlqgQLKOrdLXtp2OQlMh24IaA1QQiQCk=";
    mocha = "sha256-Tx2fQteL4wxhV+qHYZibakiYoEhS4HjyMO0yBcU/F6Q=";
  };
in
{
  options.programs.glamour.catppuccin =
    lib.ctp.mkCatppuccinOpt "glamour";

  config = {
    home.sessionVariables = lib.mkIf enable {
      GLAMOUR_STYLE = pkgs.fetchurl {
        url = "https://github.com/catppuccin/glamour/releases/download/v${version}/${cfg.flavour}.json";
        hash = hashes.${cfg.flavour};
      };
    };
  };
}

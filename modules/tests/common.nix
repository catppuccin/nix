{ pkgs, ... }:

{
  catppuccin = {
    enable = true;
    sources = {
      # this is used to ensure that we are able to apply
      # source overrides without breaking the other sources
      palette = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "palette";
        rev = "16726028c518b0b94841de57cf51f14c095d43d8"; # refs/tags/1.1.1~1
        hash = "sha256-qZjMlZFTzJotOYjURRQMsiOdR2XGGba8XzXwx4+v9tk=";
      };
    };
  };
}

{ mkMultiSearch, pkgs }:

{ catppuccin, versionName }:

let
  urlPrefix = "https://github.com/catppuccin/nix/tree/${catppuccin.rev or "main"}/";
in

mkMultiSearch {
  title = "catppuccin/nix Option Search";
  baseHref = "/search/${versionName}/";

  scopes = [
    {
      name = "NixOS modules";
      modules = [
        catppuccin.nixosModules.catppuccin
        { _module.args = { inherit pkgs; }; }
      ];
      inherit urlPrefix;
    }
    {
      name = "home-manager modules";
      modules = [
        catppuccin.homeManagerModules.catppuccin
        { _module.args = { inherit pkgs; }; }
      ];
      inherit urlPrefix;
    }
  ];
}

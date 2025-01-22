{ mkMultiSearch }:

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
      modules = [ catppuccin.nixosModules.catppuccin ];
      inherit urlPrefix;
    }
    {
      name = "home-manager modules";
      modules = [ catppuccin.homeManagerModules.catppuccin ];
      inherit urlPrefix;
    }
  ];
}

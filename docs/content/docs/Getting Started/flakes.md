---
title: Flakes
description: Start using Catppuccin with Flakes, NixOS, and home-manager
---

# Flakes

Flakes are the preferred way to use `catppuccin/nix` and will be the easiest method for most.

First, we need to add the project to our inputs so we can use it in our configurations:

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
  };
}
```

After, we can use them in a NixOS configuration like so

```nix
{
  nixosConfigurations.pepperjacks-pc = {
    modules = [
      ./configuration.nix

      catppuccin.nixosModules.catppuccin
      # if you use home-manager
      home-manager.nixosModules.home-manager

      {
        # if you use home-manager
        home-manager.users.pepperjack = {
          imports = [
            ./home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      }
    ];
  };
}
```

or if you use a [standalone installation](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) of `home-manager`

```nix
{
  homeConfigurations.pepperjack = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      ./home.nix
      catppuccin.homeManagerModules.catppuccin
    ];
  };
}
```

By the end, you should have a flake.nix that looks something like this

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, catppuccin, home-manager }: {
    # for nixos module home-manager installations
    nixosConfigurations.pepperjacksComputer = pkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix

        catppuccin.nixosModules.catppuccin
        # if you use home-manager
        home-manager.nixosModules.home-manager

        {
          # if you use home-manager
          home-manager.users.pepperjack = {
            imports = [
              ./home.nix
              catppuccin.homeManagerModules.catppuccin
            ];
          };
        }
      ];
    };

    # for standalone home-manager installations
    homeConfigurations.pepperjack = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
        catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
```
